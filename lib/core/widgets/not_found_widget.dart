import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../generated/assets.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({
    super.key,
    this.text,
    this.icon,
    this.child,
  });

  final String? text;
  final Widget? child;
  final dynamic icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageMultiType(
          url: icon ?? Assets.iconsEmpty,
          height: 1.0.sh,
          width: 1.0.sw,
        ),
        Positioned(
          bottom: 0.2.sh,
          child: DrawableText(
            size: 16.0.sp,
            text: text ?? '',
            fontWeight: FontWeight.bold,
            matchParent: true,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
