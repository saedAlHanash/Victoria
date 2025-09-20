import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:victoria/core/widgets/see_all_header.dart';
import 'package:victoria/router/app_router.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/products_cubit/products_cubit.dart';
import 'item_product.dart';

class GeneralProducts extends StatelessWidget {
  const GeneralProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductsCubit>()..getData(type: GetProductsType.non),
      child: Builder(
        builder: (context) {
          return BlocBuilder<ProductsCubit, ProductsInitial>(
            builder: (context, state) {
              final list = state.result.take(3).toList();
              return Column(
                children: [
                  SeeAllHeader(
                    title: S.of(context).generalProducts,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteName.products,
                        arguments: [context.read<ProductsCubit>(), S.of(context).generalProducts],
                      );
                    },
                  ),
                  10.0.verticalSpace,
                  SizedBox(
                    height: 220.0.h,
                    width: 1.0.sw,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: list.length,
                      separatorBuilder: (_, i) => 10.0.horizontalSpace,
                      itemBuilder: (_, i) {
                        final item = list[i];
                        return ItemProduct(product: item);
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
