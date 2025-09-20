import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:victoria/core/util/my_style.dart';

import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/my_expansion/item_expansion.dart';
import '../../../../core/widgets/my_expansion/my_expansion_widget.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/orders_cubit/orders_cubit.dart';
import '../widget/item_order_widget.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).myOrders),
      body: BlocBuilder<OrdersCubit, OrdersInitial>(
        builder: (context, state) {
          final list = state.result;

          if (list.isEmpty && !state.loading) {
            return NotFoundWidget(
              text: S.of(context).emptyOrders,
              icon: Assets.imagesEmpty,
            );
          }

          return RefreshWidget(
            isLoading: state.loading,
            onRefresh: () {
              context.read<OrdersCubit>().getData(newData: true);
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.0).r,
              child: MyExpansionWidget(
                decoration: MyStyle.roundBoxGray,
                elevation: 0.0,
                items: list
                    .mapIndexed(
                      (i, e) => ItemExpansion(
                        id: e.id,
                        body: ItemOrderBody(order: e),
                        header: ItemOrderWidget(
                          order: e,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
