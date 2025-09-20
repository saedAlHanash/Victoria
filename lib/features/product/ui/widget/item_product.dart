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
      child: CustomPaint(
        size: Size(1.0.sw, (1.0.sw * 1.430232558139535).toDouble()),
        //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically

        painter: RPSCustomPainter(),
        child: Container(
          width: 150.w,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColorManager.cardColor),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 110.0.h,
                child: Stack(
                  children: [
                    RoundImageWidget(
                      url: product.image.firstOrNull,
                      height: 118.0.h,
                      width: 1.0.sw,
                      radios: 8.0.r,
                    ),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: FavBtnWidget(product: product),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DrawableText(
                        text: product.name,
                        maxLines: 1,
                        matchParent: true,
                      ),
                      4.0.verticalSpace,
                      Column(
                        children: [
                          if (product.priceAfter != product.price)
                            DrawableText(
                              matchParent: true,
                              text: product.price.formatPrice,
                              textDecoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              size: 12.0.sp,
                            ),
                          2.0.verticalSpace,
                          DrawableText(
                            matchParent: true,
                            text: product.priceAfter.formatPrice,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            size: 12.0.sp,
                          ),
                        ],
                      ),
                      5.0.verticalSpace,
                      AddToCartProductCard(product: product),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8837209, 0);
    path_0.cubicTo(
        size.width * 0.9479419, 0, size.width, size.height * 0.03639963, size.width, size.height * 0.08130081);
    path_0.lineTo(size.width, size.height * 0.9186992);
    path_0.cubicTo(
        size.width, size.height * 0.9636016, size.width * 0.9479419, size.height, size.width * 0.8837209, size.height);
    path_0.lineTo(size.width * 0.4935273, size.height);
    path_0.cubicTo(size.width * 0.4293081, size.height, size.width * 0.3772483, size.height * 0.9636016,
        size.width * 0.3772483, size.height * 0.9186992);
    path_0.lineTo(size.width * 0.3772483, size.height * 0.8983740);
    path_0.cubicTo(size.width * 0.3772483, size.height * 0.8534715, size.width * 0.3251826, size.height * 0.8170732,
        size.width * 0.2609634, size.height * 0.8170732);
    path_0.lineTo(size.width * 0.1162791, size.height * 0.8170732);
    path_0.cubicTo(
        size.width * 0.05205988, size.height * 0.8170732, 0, size.height * 0.7806748, 0, size.height * 0.7357724);
    path_0.lineTo(0, size.height * 0.08130081);
    path_0.cubicTo(0, size.height * 0.03639963, size.width * 0.05205994, 0, size.width * 0.1162791, 0);
    path_0.lineTo(size.width * 0.8837209, 0);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColorManager.white;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
