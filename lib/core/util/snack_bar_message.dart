import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/core/strings/enum_manager.dart';

import '../../generated/l10n.dart';
import '../app/app_widget.dart';
import '../strings/app_color_manager.dart';
import '../widgets/my_button.dart';
import '../widgets/snake_bar_widget.dart';

class NoteMessage {
  static void showSuccessSnackBar({required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  static void showErrorSnackBar({required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  static void showSnakeBar({
    required String? message,
    required BuildContext context,
  }) {
    final snack = SnackBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      content: SnakeBarWidget(text: message ?? ''),
    );

    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  static Future<void> showBottomSheet({required Widget child}) async {
    showModalBottomSheet(
      context: ctx!,
      constraints: BoxConstraints(maxHeight: 0.7.sh),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      isScrollControlled: true,
      builder: (cx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(cx).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: child,
          ),
        );
      },
    );
  }

  static Future<bool> showConfirm(BuildContext context, {required String text}) async {
    // show the dialog
    final result = await showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (BuildContext context) {
        return Dialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0.r),
            ),
          ),
          elevation: 10.0,
          clipBehavior: Clip.hardEdge,
          child: Padding(
            padding: const EdgeInsets.all(15.0).r,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DrawableText(
                  text: text,
                  size: 22.0.spMin,
                  fontFamily: FontManager.bold.name,
                  color: AppColorManager.mainColorDark,
                ),
                40.0.verticalSpace,
                MyButton(
                  text: S.of(context).confirm,
                  onTap: () => Navigator.pop(context, true),
                ),
                10.0.verticalSpace,
                MyButton(
                  text: S.of(context).cancel,
                  onTap: () => Navigator.pop(context, false),
                  color: AppColorManager.black,
                ),
                20.0.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
    return (result ?? false);
  }

  static Future<bool> showErrorDialog(BuildContext context, {required String text, bool tryAgne = true}) async {
    // show the dialog
    final result = await showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (BuildContext context) {
        return Dialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0.r)),
          ),
          elevation: 10.0,
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DrawableText(
                text: 'Oops!',
                size: 20.0.spMin,
                padding: const EdgeInsets.symmetric(vertical: 15.0).h,
                fontFamily: FontManager.bold.name,
                color: AppColorManager.textColor,
              ),
              Divider(height: 25.0.h, color: Colors.black),
              DrawableText(
                text: text,
                textAlign: TextAlign.center,
                size: 16.0.spMin,
                padding: const EdgeInsets.symmetric(vertical: 20.0).h,
                fontFamily: FontManager.bold.name,
                color: AppColorManager.textColor,
              ),
              Divider(height: 25.0.h, color: Colors.black),
              TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: DrawableText(text: tryAgne ? 'Try Again' : 'OK'))
            ],
          ),
        );
      },
    );

    return (result ?? false);
  }

  static void showDialogError(
    BuildContext context, {
    required String text,
  }) {
    // show the dialog
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (BuildContext context) {
        return Dialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0.r)),
          ),
          elevation: 10.0,
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DrawableText(
                text: 'Oops!',
                size: 20.0.spMin,
                padding: const EdgeInsets.symmetric(vertical: 15.0).h,
                fontFamily: FontManager.bold.name,
                color: AppColorManager.textColor,
              ),
              Divider(height: 25.0.h, color: Colors.black),
              DrawableText(
                text: text,
                textAlign: TextAlign.center,
                size: 16.0.spMin,
                padding: const EdgeInsets.symmetric(vertical: 20.0).h,
                fontFamily: FontManager.bold.name,
                color: AppColorManager.textColor,
              ),
              Divider(height: 25.0.h, color: Colors.black),
              TextButton(onPressed: () => Navigator.pop(context, true), child: const DrawableText(text: 'OK'))
            ],
          ),
        );
      },
    );
  }

  static Future<bool> showMyDialog(BuildContext context, {required Widget child}) async {
    // show the dialog
    final result = await showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (BuildContext context) {
        return Dialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0.r),
            ),
          ),
          insetPadding: const EdgeInsets.all(20.0).r,
          elevation: 10.0,
          clipBehavior: Clip.hardEdge,
          child: SingleChildScrollView(
            child: child,
          ),
        );
      },
    );
    return (result ?? false);
  }

  static Future<void> showAwesomeError({required BuildContext context, required String message}) async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: S.of(context).oops,
      desc: message,
    ).show();
  }

  static showAwesomeDoneDialog(BuildContext context, {required String message, Function()? onCancel}) async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      title: S.of(context).done,
      desc: message,
      onDismissCallback: (type) => onCancel?.call(),
    ).show();
  }

  static Future<void> showCheckDialog(
    BuildContext context, {
    required String text,
    required String textButton,
    dynamic image,
    Function()? onConfirm,
  }) async {
    // show the dialog
    await showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Dialog(
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0.r))),
            elevation: 10.0,
            clipBehavior: Clip.hardEdge,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 1.0.sw,
                  padding: const EdgeInsets.all(15.0).r,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.r)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (image != null)
                        ImageMultiType(
                          url: image,
                          height: 60.0.r,
                          width: 60.0.r,
                        ),
                      20.0.verticalSpace,
                      DrawableText(
                        text: text,
                        size: 20.0.sp,
                        textAlign: TextAlign.center,
                        fontFamily: FontManager.semeBold.name,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0).r,
                  child: Row(
                    children: [
                      Expanded(
                        child: MyButton(
                          color: Colors.red,
                          onTap: () {
                            Navigator.pop(context, true);
                            onConfirm?.call();
                          },
                          text: textButton,
                        ),
                      ),
                      15.0.horizontalSpace,
                      Expanded(
                        child: MyButton(
                          onTap: () => Navigator.pop(context, false),
                          text: S.of(context).no,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> showCheckAddDialog(
    BuildContext context, {
    required String text,
    required String textButton,
    required dynamic image,
    Function()? onConfirm,
  }) async {
    // show the dialog
    final result = await showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Dialog(
            surfaceTintColor: Colors.white,
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0.r),
              ),
            ),
            elevation: 10.0,
            clipBehavior: Clip.hardEdge,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 1.0.sw,
                  padding: const EdgeInsets.all(15.0).r,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: AppColorManager.f8,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.r)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      50.0.verticalSpace,
                      image is Widget
                          ? image
                          : ImageMultiType(
                              url: image,
                              height: 60.0.r,
                              width: 60.0.r,
                              color: AppColorManager.mainColor,
                            ),
                      20.0.verticalSpace,
                      DrawableText(
                        text: text,
                        size: 20.0.sp,
                        textAlign: TextAlign.center,
                        color: AppColorManager.mainColorLight,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0).r,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () => Navigator.pop(context, true),
                    child: DrawableText(
                      padding: const EdgeInsets.symmetric(vertical: 23.0).r,
                      text: textButton,
                      color: AppColorManager.mainColorLight,
                      matchParent: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (result == true) {
      onConfirm?.call();
    }
  }

  static showDoneDialog(BuildContext context, {required String text, Function()? onCancel}) {
    // show the dialog
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0.r),
            ),
          ),
          elevation: 10.0,
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              10.0.verticalSpace,
              DrawableText(
                text: text,
                size: 16.0.sp,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15).r,
                child: MyButton(
                  text: 'تم بنجاح',
                  onTap: () {
                    onCancel?.call();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
