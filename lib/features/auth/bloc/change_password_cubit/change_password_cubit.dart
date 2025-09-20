import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:victoria/core/api_manager/api_url.dart';
import 'package:victoria/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/change_password_request.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordInitial> {
  ChangePasswordCubit() : super(ChangePasswordInitial.initial());

  Future<void> changePassword({required ChangePasswordRequest request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _changePasswordApi(request: request);

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _changePasswordApi({required ChangePasswordRequest request}) async {
    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.changePassword,
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      final pair = Pair(true, null);

      return pair;
    } else {
      return response.getPairError;
    }
  }
}
