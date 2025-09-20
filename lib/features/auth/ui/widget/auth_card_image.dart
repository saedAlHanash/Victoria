import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/core/strings/app_color_manager.dart';

import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../generated/assets.dart';

class AuthCardImage extends StatelessWidget {
  const AuthCardImage({super.key, required this.titleText, required this.description, this.back = true});

  final String titleText;
  final String description;
  final bool back;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.0.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50.0.w,
              margin: EdgeInsetsDirectional.only(start: 10.0.w),
              child: BackBtnWidget(
                appBarColor: AppColorManager.mainColorLight,
              ),
            ),
            ImageMultiType(
              url: Assets.imagesLogo,
              height: 60.0.r,
              width: 60.0.r,
            ),
            60.0.horizontalSpace,
          ],
        ),
        20.0.verticalSpace,
        DrawableText(
          text: titleText,
          matchParent: true,
          textAlign: TextAlign.center,
          size: 30.0,
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          color: AppColorManager.mainColor,
          fontWeight: FontWeight.bold,
        ),
        12.0.verticalSpace,
        DrawableText(
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          text: description,
          matchParent: true,
          color: AppColorManager.mainColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
