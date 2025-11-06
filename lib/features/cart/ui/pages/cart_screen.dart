import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/helper/launcher_helper.dart';
import 'package:victoria/core/strings/enum_manager.dart';
import 'package:victoria/core/widgets/not_found_widget.dart';
import 'package:victoria/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:victoria/core/widgets/spinner_widget.dart';
import 'package:victoria/features/cart/ui/widget/coupon_widget.dart';
import 'package:victoria/features/home/bloc/home_cubit/home_cubit.dart';
import 'package:victoria/features/order/data/request/create_order_request.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../core/widgets/dashed_line.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../address/bloc/addresses_cubit/addresses_cubit.dart';

import '../../../order/bloc/orders_cubit/orders_cubit.dart';
import '../../bloc/cart_cubit/cart_cubit.dart';
import '../../bloc/coupon_cubit/coupon_cubit.dart';
import '../widget/item_cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<OrdersCubit, OrdersInitial>(
          listenWhen: (p, c) => c.done && c.create,
          listener: (context, state) {
            context.read<CartCubit>()
              ..clearCash()
              ..getDataFromCache();

            context.read<HomeCubit>().jumpPage(0);

            Navigator.pushNamed(context, RouteName.orders);
            if (!state.payOrder.paymentId.isBlankNumber) {
              LauncherHelper.openPage(state.payOrder.paymentUrl);
            }

            NoteMessage.showSuccessSnackBar(context: context, message: S.of(context).done);
            context.read<OrdersCubit>().reInitial();
          },
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<OrdersCubit, OrdersInitial>(
          buildWhen: (p, c) => c.create,
          builder: (context, oState) {
            return BlocBuilder<CartCubit, CartInitial>(
              builder: (context, state) {
                return RefreshWidget(
                  isLoading: state.loading,
                  onRefresh: () => context.read<CartCubit>().getDataFromCache(),
                  child: state.isDataEmpty
                      ? NotFoundWidget()
                      : ListView(
                          padding: EdgeInsets.symmetric(horizontal: 24.0).r,
                          children: [
                            for (var e in state.result) ItemProductCart(product: e),
                            if (!AppProvider.isGuest) ...[
                              20.0.verticalSpace,
                              const CouponWidget(),
                              SpinnerWidget(
                                items: PaymentMethod.values
                                    .getSpinnerItems(selectedId: oState.cRequest.paymentMethod.index),
                                hintLabel: 'طريقة الدفع',
                                onChanged: (spinnerItem) {
                                  oState.cRequest.paymentMethod = spinnerItem.item;
                                },
                              ),
                              20.0.verticalSpace,
                              BlocBuilder<AddressesCubit, AddressesInitial>(
                                builder: (context, aState) {
                                  return SpinnerWidget(
                                    onChanged: (spinnerItem) {
                                      if (spinnerItem.id < 0) {
                                        Navigator.pushNamed(context, RouteName.address);
                                      }
                                      context.read<CartCubit>().setAddress(spinnerItem.item);
                                    },
                                    loading: aState.loading,
                                    hintText: S.of(context).selectAddress,
                                    hintLabel: S.of(context).selectAddress,
                                    items: aState.getSpinnerItems(
                                      selectedId: state.address.id.toString(),
                                    ),
                                  );
                                },
                              ),
                              20.0.verticalSpace,
                            ],
                            _TotalWidget(),
                            20.0.verticalSpace,
                            if (!AppProvider.isGuest)
                              MyButton(
                                loading: oState.loading,
                                color: AppColorManager.mainColor,
                                onTap: () {
                                  context.read<OrdersCubit>().state.cRequest
                                    ..couponCode = state.couponCode
                                    ..address = state.address
                                    ..products =
                                        state.result.map((e) => ProductDto(id: e.id, quantity: e.count)).toList();

                                  context.read<OrdersCubit>().create();
                                },
                                enable: (state.address.id != 0) && state.result.isNotEmpty,
                                text: S.of(context).continueTo,
                              )
                            else
                              MyButton(
                                text: S.of(context).login,
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(context, RouteName.login, (route) => false);
                                },
                              ),
                          ],
                        ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DrawableText(
      text: title,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      color: Colors.black38,
      matchParent: true,
      drawableEnd: DrawableText(text: value),
    );
  }
}

class _TotalWidget extends StatelessWidget {
  const _TotalWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartInitial>(
      builder: (context, state) {
        return Column(
          children: [
            DrawableText(
              size: 18.0.sp,
              matchParent: true,
              fontWeight: FontWeight.bold,
              text: S.of(context).orderInfo,
            ),
            _Item(
              title: S.of(context).subtotal,
              value: state.productsPrice.formatPrice,
            ),
            if (!state.address.id.isBlankNumber)
              _Item(
                title: S.of(context).deliveryPrice,
                value: state.address.governorate.deliveryPrice.formatPrice,
              ),
            BlocBuilder<CouponCubit, CouponInitial>(
              builder: (context, cState) {
                return _Item(
                  title: S.of(context).discount,
                  value: cState.result.calculateDiscount(state.productsPrice).formatPrice,
                );
              },
            ),
            8.0.verticalSpace,
            SizedBox(
              width: 1.0.sw,
              child: DashedLine(),
            ),
            12.0.verticalSpace,
            _Item(
              title: S.of(context).total,
              value: state.totalPrice.formatPrice,
            ),
            20.0.verticalSpace,
          ],
        );
      },
    );
  }
}
