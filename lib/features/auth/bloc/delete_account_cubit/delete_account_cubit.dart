import 'package:flutter/material.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:victoria/core/api_manager/api_url.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/strings/enum_manager.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/snack_bar_message.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends MCubit<DeleteAccountInitial> {
  DeleteAccountCubit() : super(DeleteAccountInitial.initial());

  Future<void> deleteAccount(BuildContext context) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _logoutApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      await AppProvider.logout();
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _logoutApi() async {
    final response = await APIService().callApi(
      type: ApiType.delete,
      url: DeleteUrl.deleteMyAccount,
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
