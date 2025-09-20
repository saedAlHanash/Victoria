import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/core/strings/app_color_manager.dart';
import 'package:victoria/features/address/data/request/create_address_request.dart';

import '../../../../core/util/snack_bar_message.dart';
import '../../../../generated/assets.dart';
import '../../bloc/addresses_cubit/addresses_cubit.dart';
import '../../bloc/my_location_cubit/my_location_cubit.dart';
import '../../data/response/address_response.dart';
import 'add_address.dart';

class ItemAddress extends StatelessWidget {
  const ItemAddress({super.key, required this.address});

  final Address address;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColorManager.cardColor),
        borderRadius: BorderRadius.circular(12.0.r),
      ),
      child: ListTile(
        leading: ImageMultiType(url: Assets.iconsLocationPin),
        title: DrawableText(
          matchParent: true,
          text: address.name,
          drawableEnd: _UpdateDelete(address: address),
        ),
        subtitle: DrawableText(text: address.governorate.name),
      ),
    );
  }
}

class _UpdateDelete extends StatelessWidget {
  const _UpdateDelete({super.key, required this.address});

  final Address address;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            NoteMessage.showBottomSheet(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: context.read<MyLocationCubit>(),
                  ),
                  BlocProvider.value(
                    value: context.read<AddressesCubit>()
                      ..setRequest(
                        CreateAddressRequest(
                          id: address.id,
                          governorate: address.governorate,
                          name: address.name,
                          longitude: address.longitude,
                          latitude: address.latitude,
                        ),
                      ),
                  ),
                ],
                child: AddAddressBottomSheet(),
              ),
            );
          },
          child: ImageMultiType(
            url: Assets.iconsEdit,
            width: 15.0.r,
          ),
        ),
        15.0.horizontalSpace,
        BlocBuilder<AddressesCubit, AddressesInitial>(
          builder: (context, state) {
            return InkWell(
                onTap: () {
                  context.read<AddressesCubit>().deleteNow(
                        id: address.id.toString(),
                      );
                },
                child: ImageMultiType(url: Assets.iconsTrash, width: 15.0.r));
          },
        ),
      ],
    );
  }
}
