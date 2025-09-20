import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../bloc/category_cubit/category_cubit.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CategoryCubit, CategoryInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {},
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget(),
        body: BlocBuilder<CategoryCubit, CategoryInitial>(
          builder: (context, state) {
            return RefreshWidget(
              isLoading: state.loading,
              onRefresh: () {
                context.read<CategoryCubit>().getData(newData: true);
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
