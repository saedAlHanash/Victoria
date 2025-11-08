import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/need_login_widget.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../product/ui/widget/item_product.dart';
import '../../bloc/favorites_cubit/favorites_cubit.dart';
import '../widget/item_favorite.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoritesCubit, FavoritesInitial>(
        builder: (context, state) {
          if (AppProvider.isGuest) {
            return NeedLoginWidget();
          }
          return RefreshWidget(
            isLoading: state.loading,
            onRefresh: () => context.read<FavoritesCubit>().getData(newData: true),
            child: state.isDataEmpty
                ? NotFoundWidget()
                : GridView.builder(
                    padding: EdgeInsets.all(20.0).r,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0.r,
                      mainAxisSpacing: 20.0.r,
                      mainAxisExtent: 220.0.h,
                    ),
                    itemCount: state.result.length,
                    itemBuilder: (_, i) {
                      final item = state.result[i];
                      return ItemProduct(product: item);
                    },
                  ),
          );
        },
      ),
    );
  }
}
