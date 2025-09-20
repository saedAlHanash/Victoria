import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../bloc/favorite_cubit/favorite_cubit.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FavoriteCubit, FavoriteInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {},
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget(),
        body: BlocBuilder<FavoriteCubit, FavoriteInitial>(
          builder: (context, state) {
            return RefreshWidget(
              isLoading: state.loading,
              onRefresh: () {
                context.read<FavoriteCubit>().getData(newData: true);
              },
              child: ListView(
                shrinkWrap: true,
                children: [],
              ),
            );
          },
        ),
      ),
    );
  }
}
