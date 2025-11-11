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
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/product_cubit/product_cubit.dart';
import '../../data/response/product_response.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductInitial>(
      builder: (context, state) {
        final product = state.result;
        return Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(15.0).r,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: MyButton(
                    radios: 40.0.r,
                    enable: state.result.isAvailable,
                    onTap: () {
                      context.read<CartCubit>().addToCart(state.result, context: context);
                    },
                    text: S
                        .of(context)
                        .add_to_cart,
                  ),
                ),
                15.0.horizontalSpace,
                Expanded(
                  child: OutLineButton(
                    radios: 40.0.r,
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.cart);
                    },
                    text: S
                        .of(context)
                        .cart,
                  ),
                ),
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
                        top: MediaQuery
                            .of(context)
                            .padding
                            .top + 10,
                        end: 10,
                        child: FavBtnWidget(product: state.result),
                      ),
                      PositionedDirectional(
                        top: MediaQuery
                            .of(context)
                            .padding
                            .top + 10,
                        start: 10,
                        child: Transform.scale(
                          scale: 0.8,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: BackBtnWidget(appBarColor: Colors.white),
                          ),
                        ),
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
                        fontFamily: FontManager.bold.name,
                        size: 20.0,
                      ),
                      10.0.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: product.priceWidget,
                          ),
                          AmountWidgetCart(
                            product: product,
                            onIncrement: (product) {
                              setState(() {});
                            },
                            onDecrement: (product) {
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      20.0.verticalSpace,
                      Divider(),
                      DrawableText(
                        text: S
                            .of(context)
                            .description,
                        matchParent: true,
                        size: 18.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      DrawableText(
                        text: product.description,
                        matchParent: true,
                        padding: EdgeInsets
                            .symmetric(vertical: 5.0)
                            .r,
                        color: Colors.grey,
                      ),
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
          return InkWell(
            onTap: () {
              setState(() {
                widget.product.count++;
                widget.onIncrement?.call(widget.product);
              });
            },
            child: Container(
              height: 35.0.r,
              width: 35.0.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColorManager.mainColor)),
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
            ? EdgeInsets
            .symmetric(horizontal: 15.0)
            .r
            : EdgeInsets
            .symmetric(vertical: 5.0)
            .r,
        size: 20.0.sp,
        color: AppColorManager.grey,
        fontWeight: FontWeight.bold,
      ),
      Builder(
        builder: (context) {
          return InkWell(
            onTap: () {
              if (widget.product.count <= 1) return;
              setState(() {
                widget.product.count--;
                widget.onDecrement?.call(widget.product);
              });
            },
            child: Container(
              height: 35.0.r,
              width: 35.0.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColorManager.mainColor)),
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
