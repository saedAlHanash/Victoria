import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:victoria/features/address/ui/widget/item_address.dart';
import 'package:victoria/features/order/ui/widget/item_order_widget.dart';
import 'package:victoria/router/app_router.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/order_cubit/order_cubit.dart';
import '../widget/item_product.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderInitial>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarWidget(
            color: Colors.white,
            titleText: '#${state.result.id}',
            actions: [
              Center(
                child: BlocBuilder<OrderCubit, OrderInitial>(
                  builder: (context, state) {
                    if (state.loading) return 0.0.verticalSpace;

                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0).r,
                      margin: const EdgeInsets.symmetric(horizontal: 20.0).r,
                      decoration: BoxDecoration(
                        color: state.result.status.getOrderStateColorText.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8.0).r,
                        border: Border.all(
                          color: state.result.status.getOrderStateColorText,
                        ),
                      ),
                      child: DrawableText(
                        text: state.result.status.name,
                        color: state.result.status.getOrderStateColorText,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          body: RefreshWidget(
            onRefresh: () {
              context.read<OrderCubit>().getData(newData: true);
            },
            isLoading: state.loading,
            child: SingleChildScrollView(
              child: BlocBuilder<OrderCubit, OrderInitial>(
                builder: (context, state) {
                  return Column(
                    children: [
                      for (var e in state.result.products) ItemOrderProduct(product: e),
                      20.0.verticalSpace,
                      OrderPrices(order: state.result),
                      Divider(),
                      ListTile(
                        leading: ImageMultiType(url: Assets.iconsLocationPin, width: 25.0.r),
                        title: DrawableText(
                          matchParent: true,
                          text: state.result.address.name,
                        ),
                        subtitle: DrawableText(text: state.result.address.governorate.name),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RouteName.map, arguments: state.result.address.getLatLng);
                          },
                          icon: ImageMultiType(url: Icons.map),
                          color: AppColorManager.mainColor,
                        ),
                      ),
                      Divider(),
                      20.0.verticalSpace,
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
