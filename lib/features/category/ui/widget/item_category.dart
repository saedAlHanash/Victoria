import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../data/response/category_response.dart';

class ItemCategory extends StatelessWidget {
  const ItemCategory({super.key, required this.category, required this.onTap, this.selected = false});

  final Category category;
  final bool selected;
  final Function(Category category) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorManager.cardColor,
        border: selected
            ? Border.all(color: AppColorManager.mainColor, width: 2, strokeAlign: BorderSide.strokeAlignOutside)
            : null,
        borderRadius: BorderRadius.circular(12.0).r,
      ),
      clipBehavior: Clip.hardEdge,
      width: 0.2.sw,
      child: InkWell(
        onTap: () => onTap.call(category),
        child: Stack(
          children: [
            ImageMultiType(
              url: category.image,
              height: 1.0.sh,
              width: 1.0.sw,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Container(
                width: 1.0.sw,
                color: Colors.black38,
                child: DrawableText(
                  text: category.name,
                  padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0).r,
                  matchParent: true,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  color: Colors.white,
                  size: category.name.length > 12 ? 10.0.sp : 11.0.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
