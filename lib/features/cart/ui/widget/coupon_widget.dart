import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:victoria/core/strings/app_color_manager.dart';
import 'package:victoria/core/widgets/my_button.dart';

import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../order/bloc/orders_cubit/orders_cubit.dart';
import '../../bloc/cart_cubit/cart_cubit.dart';
import '../../bloc/coupon_cubit/coupon_cubit.dart';

class CouponWidget extends StatelessWidget {
  const CouponWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CouponCubit, CouponInitial>(
      listenWhen: (p, c) => c.done,
      listener: (context, state) {
        context.read<CartCubit>()
          ..setCouponCode(state.coupon)
          ..setCoupon(state.result);
      },
      builder: (context, state) {
        return Column(
          children: [
            MyTextFormOutLineWidget(
              label: S.of(context).coupon_code,
              onChanged: (p0) => context.read<CouponCubit>().setCoupon(p0),
              innerPadding: const EdgeInsets.symmetric(horizontal: 10.0).w,
              iconWidgetLift: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
                child: MyButton(
                  width: 74.0.w,
                  height: 35.0.h,
                  color: Colors.transparent,
                  textColor: AppColorManager.mainColor,
                  loading: state.loading,
                  onTap: () {
                    context.read<CouponCubit>().applyCoupon();
                  },
                  text: 'Check',
                ),
              ),
              iconWidget: state.done
                  ? const ImageMultiType(
                      url: Icons.done,
                      color: Colors.green,
                    )
                  : null,
            ),
            if (state.statuses == CubitStatuses.error)
              Container(
                padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0).r,
                decoration: BoxDecoration(
                  color: Color(0xffFFF4EC),
                  borderRadius: BorderRadius.circular(8.0.r),
                ),
                child: DrawableText(
                  text: state.error,
                  color: Color(0xffB95000),
                  matchParent: true,
                  drawablePadding: 5.0,
                  drawableStart: ImageMultiType(
                    url: Icons.info_rounded,
                    height: 15.0.r,
                    color: Color(0xffB95000),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
