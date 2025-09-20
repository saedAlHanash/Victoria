import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';

import '../../bloc/address_cubit/address_cubit.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddressCubit, AddressInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {},
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget(),
        body: BlocBuilder<AddressCubit, AddressInitial>(
          builder: (context, state) {
            return RefreshWidget(
              isLoading: state.loading,
              onRefresh: () {
                context.read<AddressCubit>().getData(newData: true);
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


