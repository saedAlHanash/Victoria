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
import 'package:victoria/router/app_router.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../governorate/bloc/governorates_cubit/governorates_cubit.dart';
import '../../bloc/addresses_cubit/addresses_cubit.dart';
import '../../bloc/my_location_cubit/my_location_cubit.dart';
import '../widget/item_address.dart';

class AddAddressBottomSheet extends StatefulWidget {
  const AddAddressBottomSheet({super.key});

  @override
  State<AddAddressBottomSheet> createState() => _AddAddressBottomSheetState();
}

class _AddAddressBottomSheetState extends State<AddAddressBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MyLocationCubit, MyLocationInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            setState(() {
              context.read<AddressesCubit>().state.cRequest
                ..longitude = state.result.longitude
                ..latitude = state.result.latitude;
            });
          },
        ),
        BlocListener<AddressesCubit, AddressesInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            context.read<AddressesCubit>().getData(newData: true);
            Navigator.pop(context);
          },
        ),
      ],
      child: BlocBuilder<AddressesCubit, AddressesInitial>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                30.0.verticalSpace,
                BlocBuilder<GovernoratesCubit, GovernoratesInitial>(
                  builder: (context, gState) {
                    return SpinnerWidget(
                      onChanged: (spinnerItem) {
                        context.read<AddressesCubit>().state.cRequest.governorate = spinnerItem.item;
                      },
                      hintLabel: S.of(context).selectAGovernorate,
                      hintText: S.of(context).selectAGovernorate,
                      loading: gState.loading,
                      items: gState.getSpinnerItems(
                        selectedId: state.cRequest.governorate.id.toString(),
                      ),
                    );
                  },
                ),
                20.0.verticalSpace,
                MyTextFormOutLineWidget(
                  label: S.of(context).locationName,
                  initialValue: state.cRequest.name,
                  onChanged: (p0) {
                    state.cRequest.name = p0;
                  },
                ),
                DrawableText(
                  text: '${S.of(context).selectFineLocationMethod}: ',
                  fontWeight: FontWeight.bold,
                  matchParent: true,
                  size: 16.0.sp,
                ),
                10.0.verticalSpace,
                ListTile(
                  leading: const Icon(Icons.map),
                  title: DrawableText(text: S.of(context).selectFromMap),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteName.map,
                      arguments: state.cRequest.getLatLng,
                    ).then((value) {
                      if (value != null && value is LatLng) {
                        setState(() {
                          context.read<AddressesCubit>().state.cRequest
                            ..longitude = value.longitude
                            ..latitude = value.latitude;
                        });
                      }
                    });
                  },
                ),
                const Divider(), // خط فاصل بين العناصر

                BlocBuilder<MyLocationCubit, MyLocationInitial>(
                  builder: (context, state) {
                    return ListTile(
                      leading: const Icon(Icons.my_location),
                      title: DrawableText(text: S.of(context).myLocation),
                      trailing: state.loading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : null,
                      onTap: () {
                        context.read<MyLocationCubit>().getMyLocation(context);
                      },
                    );
                  },
                ),
                10.0.verticalSpace,
                if (state.cRequest.latitude != 0 && state.cRequest.longitude != 0)
                  Container(
                    width: 1.0.sw,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5).r,
                    decoration: BoxDecoration(
                      color: AppColorManager.mainColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12.0.r),
                    ),
                    child: Center(
                      child: DrawableText(
                          size: 12.0.sp,
                          text: '${S.of(context).locationSelected}: ${state.cRequest.getLatLng.stringPrint}'),
                    ),
                  ),
                30.0.verticalSpace,
                MyButton(
                  enable: state.cRequest.longitude != 0 && state.cRequest.latitude != 0,
                  loading: state.loading,
                  text: S.of(context).addNewAddress,
                  icon: ImageMultiType(url: Icons.add, color: Colors.white),
                  onTap: () {
                    context.read<AddressesCubit>().createOrUpdate();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
