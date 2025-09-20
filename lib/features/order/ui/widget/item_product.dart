import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:victoria/core/extensions/extensions.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../router/app_router.dart';
import '../../../product/data/response/product_response.dart';

class ItemOrderProduct extends StatelessWidget {
  const ItemOrderProduct({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0).h,
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, RouteName.product, arguments: product.id);
        },
        leading: RoundImageWidget(
          url: product.image.firstOrNull,
          height: 54.0.r,
          width: 54.0.r,
        ),
        title: DrawableText(
          size: 14.0.sp,
          text: product.name,
          maxLines: 2,
          matchParent: true,
          drawableAlin: DrawableAlin.between,
          drawablePadding: 15.0.w,
          drawableEnd: DrawableText(
            size: 16.0.sp,
            text: product.price.formatPrice,
            color: AppColorManager.mainColor,
          ),
        ),
      ),
    );
  }
}
