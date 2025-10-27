import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/util/my_style.dart';
import 'package:victoria/core/widgets/card_slider_widget.dart';
import 'package:victoria/core/widgets/my_button.dart';
import 'package:victoria/features/cart/bloc/cart_cubit/cart_cubit.dart';
import 'package:victoria/features/favorite/ui/widget/fav_btn_widget.dart';
import 'package:victoria/features/product/ui/widget/relates_products.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/product_cubit/product_cubit.dart';
import '../../data/response/product_response.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductInitial>(
      builder: (context, state) {
        final product = state.result;
        return Scaffold(
          appBar: AppBarWidget(color: Colors.white),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(15.0).r,
            child: Row(
              children: [
                Expanded(
                    child: MyButton(
                  onTap: () {
                    context.read<CartCubit>().addToCart(state.result);
                  },
                  text: S.of(context).add_to_cart,
                )),
              ],
            ),
          ),
          body: RefreshWidget(
            isLoading: state.loading,
            onRefresh: () {
              context.read<ProductCubit>().getData(newData: true);
            },
            child: ListView(
              children: [
                Container(
                  color: AppColorManager.ef,
                  child: CardImageSlider(
                    images: state.result.image,
                    stackChild: [
                      PositionedDirectional(
                        top: 10,
                        start: 10,
                        child: FavBtnWidget(product: state.result),
                      ),
                    ],
                    height: 293.0.h,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0).r,
                  child: Column(
                    children: [
                      DrawableText(
                        text: state.result.name,
                        matchParent: true,
                        drawableEnd: DrawableText(
                          text: '(${S.of(context).quantity}:${product.quantity})',
                          color: Colors.grey,
                        ),
                        size: 18.0,
                      ),
                      10.0.verticalSpace,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: product.priceWidgetH1,
                          ),
                          AmountWidgetCart(product: product),
                        ],
                      ),
                      10.0.verticalSpace,
                      if (product.description.isNotEmpty) ...[
                        20.0.verticalSpace,
                        Column(
                          children: [
                            DrawableText(
                              text: S.of(context).description,
                              size: 18.0.sp,
                              matchParent: true,
                            ),
                            DrawableText(
                              text: product.description,
                              matchParent: true,
                              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0).r,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                      10.0.verticalSpace,
                      RelatedProducts(product: product),
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
}

class AmountWidgetCart extends StatefulWidget {
  const AmountWidgetCart({
    super.key,
    required this.product,
    this.axis = Axis.horizontal,
    this.onDecrement,
    this.onIncrement,
  });

  final Product product;
  final Axis axis;
  final Function(Product product)? onDecrement;

  final Function(Product product)? onIncrement;

  @override
  State<AmountWidgetCart> createState() => _AmountWidgetCartState();
}

class _AmountWidgetCartState extends State<AmountWidgetCart> {
  @override
  Widget build(BuildContext context) {
    final items = [
      Builder(
        builder: (context) {
          return Container(
            height: 24.0.r,
            width: 24.0.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColorManager.mainColor)),
            child: InkWell(
              onTap: () {
                setState(() {
                  widget.product.count++;
                  widget.onIncrement?.call(widget.product);
                });
              },
              child: ImageMultiType(
                url: Icons.add,
                color: AppColorManager.mainColor,
                width: 18.0.r,
              ),
            ),
          );
        },
      ),
      DrawableText(
        text: widget.product.count.toString(),
        padding: widget.axis == Axis.horizontal
            ? EdgeInsets.symmetric(horizontal: 15.0).r
            : EdgeInsets.symmetric(vertical: 5.0).r,
        color: Colors.black,
      ),
      Builder(
        builder: (context) {
          return Container(
            height: 24.0.r,
            width: 24.0.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColorManager.mainColor)),
            child: InkWell(
              onTap: () {
                if (widget.product.count <= 1) return;
                setState(() {
                  widget.product.count--;
                  widget.onDecrement?.call(widget.product);
                });
              },
              child: ImageMultiType(
                url: Icons.remove,
                color: AppColorManager.mainColor,
                width: 18.0.r,
              ),
            ),
          );
        },
      ),
    ];

    switch (widget.axis) {
      case Axis.horizontal:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items,
        );

      case Axis.vertical:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items,
        );
    }
  }
}
