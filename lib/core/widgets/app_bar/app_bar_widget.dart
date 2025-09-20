import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/core/strings/enum_manager.dart';

import '../../../generated/assets.dart';
import '../../strings/app_color_manager.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    this.titleText,
    this.elevation,
    this.zeroHeight,
    this.leading,
    this.actions,
    this.title,
    this.color,
    this.canPop = true,
    this.imageAppBar = false,
    this.imageFromPage,
    this.onPopInvoked,
  });

  final String? titleText;
  final Widget? title;
  final Widget? leading;
  final Color? color;
  final bool? zeroHeight;
  final double? elevation;
  final List<Widget>? actions;
  final bool canPop;
  final bool imageAppBar;
  final Widget? imageFromPage;

  final Function(bool, dynamic result)? onPopInvoked;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: onPopInvoked,
      child: AppBar(
        backgroundColor: color ?? AppColorManager.white,
        surfaceTintColor: color ?? AppColorManager.white,
        toolbarHeight: (zeroHeight ?? false) ? 0 : 70.0.h,
        // scrolledUnderElevation: 0,
        title: title ??
            DrawableText(
              text: titleText ?? '',
              size: 18.0.spMin,
              color: isColorDark(color ?? AppColorManager.mainColor) ? Colors.white : null,
            ),
        leading: leading ??
            (Navigator.canPop(context)
                ? BackBtnWidget(
                    canPop: canPop,
                    onPopInvoked: onPopInvoked,
                    appBarColor: imageAppBar ? AppColorManager.black : color ?? AppColorManager.mainColor,
                  )
                : null),
        flexibleSpace: imageFromPage ??
            (imageAppBar
                ? Column(
                    children: [
                      MediaQuery.of(context).padding.top.verticalSpace,
                      ImageMultiType(
                        height: 70.h,
                        width: 1.sw,
                        fit: BoxFit.fill,
                        url: Assets.iconsAppBarBack,
                      ),
                      // MediaQuery.of(context).padding.top.verticalSpace,
                    ],
                  )
                : null),
        centerTitle: true,
        actions: actions,
        elevation: elevation ?? 0.0,
        shadowColor: AppColorManager.black.withValues(alpha: 0.28),
        iconTheme: const IconThemeData(color: AppColorManager.mainColor),
      ),
    );
  }

  @override
  Size get preferredSize => Size(1.0.sw, (zeroHeight ?? false) ? 0 : 70.0.h);
}

class BackBtnWidget extends StatelessWidget {
  const BackBtnWidget({
    super.key,
    required this.appBarColor,
    this.canPop = true,
    this.onPopInvoked,
  });

  final Color appBarColor;
  final bool canPop;

  final Function(bool, dynamic)? onPopInvoked;

  @override
  Widget build(BuildContext context) {
    if (!Navigator.canPop(context)) return 0.0.verticalSpace;
    return IconButton(
      onPressed: () {
        if (!canPop) {
          onPopInvoked?.call(false, null);
          return;
        }
        if (!Navigator.canPop(context)) return;
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: isColorDark(appBarColor) ? Colors.white : AppColorManager.black,
      ),
    );
  }
}
