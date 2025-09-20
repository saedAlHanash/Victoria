import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../bloc/adss_cubit/adss_cubit.dart';
import '../widgets/item_ads.dart';

class AdssPage extends StatelessWidget {
  const AdssPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: BlocBuilder<AdssCubit, AdssInitial>(
        builder: (context, state) {
          return RefreshWidget(
            isLoading: state.loading,
            onRefresh: () => context.read<AdssCubit>().getData(newData: true),
            child: ListView.separated(
              itemCount: state.result.length,
              separatorBuilder: (_, i) => 10.0.verticalSpace,
              itemBuilder: (_, i) {
                final item = state.result[i];
                return ItemAds(ads: item);
              },
            ),
          );
        },
      ),
    );
  }
}
