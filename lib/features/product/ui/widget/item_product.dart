import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/widgets/my_button.dart';
import 'package:victoria/features/cart/ui/widget/add_to_cart.dart';
import 'package:victoria/features/favorite/ui/widget/fav_btn_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../cart/bloc/cart_cubit/cart_cubit.dart';
import '../../data/response/product_response.dart';

class ItemProduct extends StatelessWidget {
  const ItemProduct({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteName.product, arguments: product.id.toString());
      },
      child: Container(
        width: 163.w,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColorManager.cardColor),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 118.0.h,
                  decoration: BoxDecoration(
                    color: AppColorManager.cardColor,
                    borderRadius: BorderRadius.circular(8.0.r),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: ImageMultiType(
                    url: product.image.firstOrNull,
                    height: 118.0.h,
                    width: 1.0.sw,
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: FavBtnWidget(product: product),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(

                  children: [
                    Spacer(),
                    DrawableText(
                      text: product.name,
                      size: 12.0.sp,
                      maxLines: 2,
                      matchParent: true,
                    ),
                    2.0.verticalSpace,
                    product.priceWidgetH,
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: AddToCartProductCard(product: product),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
