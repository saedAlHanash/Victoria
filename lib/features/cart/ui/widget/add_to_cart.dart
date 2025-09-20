import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/core/util/snack_bar_message.dart';

import '../../../../core/app/app_widget.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../product/data/response/product_response.dart';
import '../../bloc/cart_cubit/cart_cubit.dart';

class AddToCartProductCard extends StatelessWidget {
  const AddToCartProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      onTap: () {
        context.read<CartCubit>().addToCart(product);
      },
      color: AppColorManager.mainColor,
      radios: 16.0.r,
      height: 26.0.h,
      child: DrawableText(
        text: S.of(context).addToCart,
        size: 12.0.sp,
        color: Colors.white,
        drawablePadding: 5.0.w,
        drawableEnd: ImageMultiType(
          url: Assets.iconsCart,
          height: 10.0.r,
          color: Colors.white,
        ),
      ),
    );
  }
}
