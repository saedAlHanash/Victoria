import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../bloc/governorates_cubit/governorates_cubit.dart';
import '../widgets/item_governorate.dart';

class GovernoratesPage extends StatelessWidget {
  const GovernoratesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: BlocBuilder<GovernoratesCubit, GovernoratesInitial>(
        builder: (context, state) {
          return RefreshWidget(
            isLoading: state.loading,
            onRefresh: () => context.read<GovernoratesCubit>().getData(newData: true),
            child: ListView.separated(
              itemCount: state.result.length,
              separatorBuilder: (_, i) => 10.0.verticalSpace,
              itemBuilder: (_, i) {
                final item = state.result[i];
                return ItemGovernorate(governorate: item);
              },
            ),
          );
        },
      ),
    );
  }
}
