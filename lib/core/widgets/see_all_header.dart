import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../generated/l10n.dart';
import '../strings/app_color_manager.dart';

class SeeAllHeader extends StatelessWidget {
  const SeeAllHeader({super.key, required this.title, this.onTap});

  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return DrawableText(
      matchParent: true,
      text: title,
      fontWeight: FontWeight.bold,
      size: 18.sp,
      drawableEnd: onTap == null
          ? null
          : TextButton(
              onPressed: onTap,
              child: DrawableText(
                text: S.of(context).see_all,
                color: AppColorManager.mainColor,
                size: 12.0.sp,
                drawableEnd: ImageMultiType(
                  height: 12.0.sp,
                  url: Icons.arrow_forward_ios,
                  color: AppColorManager.mainColor,
                ),
              ),
            ),
    );
  }
}
