import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../../cart/bloc/cart_cubit/cart_cubit.dart';
import '../../data/response/product_response.dart';

class AddToCartBtn extends StatelessWidget {
  const AddToCartBtn({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartInitial>(
      builder: (context, state) {
        return InkWell(
          onTap: state.loading ? null : () async {},
          child: Container(
            height: 68.0.h,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColorManager.mainColorLight,
                  AppColorManager.mainColor,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
            child: Center(
              child: DrawableText(
                text: S.of(context).add_to_cart,
                color: Colors.white,
                matchParent: true,
                fontWeight: FontWeight.bold,
                size: 24.0.sp,
                textAlign: TextAlign.center,
                drawableAlin: DrawableAlin.between,
                drawableEnd: BlocBuilder<CartCubit, CartInitial>(
                  builder: (context, state) {
                    if (state.loading) {
                      return MyStyle.loadingWidget(color: Colors.white);
                    }

                    return ImageMultiType(
                      height: 26.0.r,
                      width: 26.0.r,
                      url: Icons.check,
                      color: Colors.white,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// class AddToCartBtnFav extends StatelessWidget {
//   const AddToCartBtnFav({super.key, required this.fav});
//
//   final Favorite fav;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AddToCartCubit, AddToCartInitial>(
//       buildWhen: (p, c) => c.id == fav.productId,
//       builder: (context, state) {
//         return InkWell(
//           onTap: state.loading
//               ? null
//               : () {
//                   context
//                       .read<AddToCartCubit>()
//                       .addToCart(productId: fav.productId, context: context);
//                 },
//           child: Container(
//             height: 30.0.r,
//             width: 30.0.r,
//             color: Colors.black,
//             child: state.loading
//                 ? MyStyle.loadingWidget(color: AppColorManager.white)
//                 : const Icon(Icons.add, color: Colors.white),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class AddToCart extends StatelessWidget {
//   const AddToCart({super.key, required this.product});
//
//   final Product product;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AddToCartCubit, AddToCartInitial>(
//       builder: (context, state) {
//         return GestureDetector(
//           onTap: state.loading ? null : () async {},
//           child: BlocBuilder<AddToCartCubit, AddToCartInitial>(
//             buildWhen: (p, c) => c.id == product.id,
//             builder: (context, state) {
//               if (state.loading) {
//                 return MyStyle.loadingWidget();
//               }
//               return Center(
//                 child: ImageMultiType(
//                   url: state.showDone ? Icons.check : Icons.add,
//                   color: Colors.black,
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
//
// class AddToCartBag extends StatelessWidget {
//   const AddToCartBag({super.key, required this.product});
//
//   final Product product;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AddToCartCubit, AddToCartInitial>(
//       builder: (context, state) {
//         return GestureDetector(
//           onTap: state.loading
//               ? null
//               : () async {
//
//                 },
//           child: BlocBuilder<AddToCartCubit, AddToCartInitial>(
//             buildWhen: (p, c) => c.id == product.id,
//             builder: (context, state) {
//               if (state.loading) {
//                 return MyStyle.loadingWidget();
//               }
//               return Container(
//                 height: 35.0.r,
//                 width: 35.0.r,
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.all(10.0).r,
//                 decoration: const BoxDecoration(
//                   color: Colors.black,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Center(
//                   child: ImageMultiType(
//                     url: state.showDone ? Icons.check : Assets.imagesLogo,
//                     color: Colors.white,
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
