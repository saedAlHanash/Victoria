import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/core/api_manager/api_service.dart';

import '../../../../core/util/my_style.dart';
import '../../../product/data/response/product_response.dart';
import '../../bloc/favorites_cubit/favorites_cubit.dart';

class FavBtnWidget extends StatelessWidget {
  const FavBtnWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(3.0).r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0.r),
        color: Colors.white,
      ),
      child: BlocBuilder<FavoritesCubit, FavoritesInitial>(
        buildWhen: (p, c) => c.mId == product.id.toString(),
        builder: (context, state) {
          if (state.loading) {
            return SizedBox(
              height: 20.0.r,
              width: 20.0.r,
              child: MyStyle.loadingWidget(),
            );
          }

          return InkWell(
            onTap: () {
              context.read<FavoritesCubit>().toggleFavorite(product);
            },
            child: ImageMultiType(
              height: 20.0.r,
              width: 20.0.r,
              url: state.result.any((e) => e.id == product.id) ? Icons.favorite : Icons.favorite_border,
              color: state.result.any((e) => e.id == product.id) ? Colors.black : null,
            ),
          );
        },
      ),
    );
  }
}
