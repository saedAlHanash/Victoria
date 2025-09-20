import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/util/snack_bar_message.dart';
import 'package:victoria/core/widgets/my_button.dart';
import 'package:victoria/core/widgets/my_text_form_widget.dart';
import 'package:victoria/core/widgets/my_text_form_widget.dart';
import 'package:victoria/core/widgets/spinner_widget.dart';
import 'package:victoria/features/address/data/request/create_address_request.dart';
import 'package:victoria/router/app_router.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../governorate/bloc/governorates_cubit/governorates_cubit.dart';
import '../../bloc/addresses_cubit/addresses_cubit.dart';
import '../../bloc/my_location_cubit/my_location_cubit.dart';
import '../widget/add_address.dart';
import '../widget/item_address.dart';

class AddressesPage extends StatelessWidget {
  const AddressesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        titleText: S.of(context).addresses,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: MyButton(
          onTap: () async {
            NoteMessage.showBottomSheet(
                child: MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: context.read<MyLocationCubit>(),
                ),
                BlocProvider.value(
                  value: context.read<AddressesCubit>()..setRequest(CreateAddressRequest.fromJson({})),
                ),
              ],
              child: AddAddressBottomSheet(),
            ));
          },
          text: S.of(context).addNewAddress,
        ),
      ),
      body: BlocBuilder<AddressesCubit, AddressesInitial>(
        builder: (context, state) {
          return RefreshWidget(
            isLoading: state.loading,
            onRefresh: () => context.read<AddressesCubit>().getData(newData: true),
            child: ListView.separated(
              padding: EdgeInsets.all(20.0).r,
              itemCount: state.result.length,
              separatorBuilder: (_, i) => 10.0.verticalSpace,
              itemBuilder: (_, i) {
                final item = state.result[i];
                return ItemAddress(address: item);
              },
            ),
          );
        },
      ),
    );
  }
}
