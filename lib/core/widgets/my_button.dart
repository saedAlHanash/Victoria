import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:victoria/core/strings/enum_manager.dart';

import '../strings/app_color_manager.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.child,
    this.icon,
    this.onTap,
    this.text = '',
    this.color,
    this.elevation,
    this.textColor,
    this.width,
    this.height,
    this.radios,
    this.enable,
    this.padding,
    this.loading = false,
    this.toUpper = true,
  });

  final Widget? child;
  final Widget? icon;
  final String text;
  final Color? textColor;
  final Color? color;
  final double? elevation;
  final double? width;
  final double? height;
  final double? radios;
  final bool? enable;
  final EdgeInsets? padding;
  final Function()? onTap;
  final bool toUpper;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final child = this.child ??
        DrawableText(
          text: toUpper ? text.toUpperCase() : text,
          color: textColor ?? AppColorManager.white,
          drawablePadding: 5.0.w,
          fontFamily: FontManager.bold.name,
          drawableEnd: loading
              ? SizedBox(
                  height: 15.0.r,
                  width: 15.0.r,
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: color,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColorManager.mainColor),
                  ),
                )
              : null,
          fontWeight: FontWeight.bold,
        );

    return SizedBox(
      width: width ?? .9.sw,
      height: height ?? 45.0.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color ?? AppColorManager.mainColor,
          borderRadius: BorderRadius.circular(radios ?? 8.0),
        ),
        child: ElevatedButton.icon(
          icon: icon,
          label: child,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            overlayColor: AppColorManager.mainColor.withValues(alpha: 0.2),
            shadowColor: Colors.transparent,
            disabledBackgroundColor: Colors.grey,
            padding: padding ?? EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radios ?? 8.0),
            ),
          ),
          iconAlignment: IconAlignment.end,
          onPressed: (loading || enable == false) ? null : onTap,
        ),
      ),
    );
  }
}

class OutLineButton extends StatelessWidget {
  const OutLineButton({
    super.key,
    this.child,
    this.onTap,
    this.text = '',
    this.color,
    this.elevation,
    this.textColor,
    this.width,
    this.height,
    this.radios,
    this.enable,
    this.toUpper = true,
    this.padding,
    this.loading = false,
  });

  final Widget? child;
  final String text;
  final Color? textColor;
  final Color? color;
  final double? elevation;
  final double? width;
  final double? height;
  final double? radios;
  final bool? enable;
  final EdgeInsets? padding;
  final Function()? onTap;
  final bool toUpper;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final child = this.child ??
        DrawableText(
          text: toUpper ? text.toUpperCase() : text,
          color: textColor ?? AppColorManager.mainColor,
          fontFamily: FontManager.bold.name,
          size: 14.0.sp,
          drawableEnd: loading
              ? SizedBox(
            height: 15.0.r,
            width: 15.0.r,
            child: CircularProgressIndicator.adaptive(
              backgroundColor: color,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
              : null,
          fontWeight: FontWeight.bold,
        );

    return SizedBox(
      width: width ?? .9.sw,
      height: height ?? 50.0.h,
      child: ElevatedButton(
        style: ButtonStyle(
          surfaceTintColor: WidgetStatePropertyAll(color ?? AppColorManager.white),
          backgroundColor: WidgetStatePropertyAll(color ?? AppColorManager.white),
          padding: WidgetStatePropertyAll(
            height != null ? EdgeInsets.zero : padding ?? const EdgeInsets.symmetric(vertical: 13.0).r,
          ),
          elevation: WidgetStatePropertyAll(0),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radios ?? 50.0.r),
              side: BorderSide(
                color: AppColorManager.mainColor,
              ),
            ),
          ),
          alignment: Alignment.center,
        ),
        onPressed: loading
            ? null
            : !(enable ?? true)
            ? null
            : onTap,
        child: child,
      ),
    );
  }
}
