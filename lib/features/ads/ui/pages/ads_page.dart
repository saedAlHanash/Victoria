import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../bloc/ads_cubit/ads_cubit.dart';

class AdsPage extends StatelessWidget {
  const AdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AdsCubit, AdsInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {},
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget(),
        body: BlocBuilder<AdsCubit, AdsInitial>(
          builder: (context, state) {
            return RefreshWidget(
              isLoading: state.loading,
              onRefresh: () {
                context.read<AdsCubit>().getData(newData: true);
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
