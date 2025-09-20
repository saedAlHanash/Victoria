import 'package:bloc/bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:victoria/core/app/app_provider.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/util/shared_preferences.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/resend_request.dart';

part 'resend_code_state.dart';

class ResendCodeCubit extends Cubit<ResendCodeInitial> {
  ResendCodeCubit() : super(ResendCodeInitial.initial());

  Future<void> resendCode({required ResendRequest request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));
    final pair = await _resendCodeApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(
        statuses: CubitStatuses.done,
        result: pair.first,
        error: pair.first!,
      ));
    }
  }

  Future<Pair<String?, String?>> _resendCodeApi() async {
    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.resendCode,
      query: state.mRequest.toJson(),
    );

    final remaining = response.jsonBodyPure['remaining_time']?.toString().tryParseOrZeroInt;

    if (response.statusCode.success) {
      return Pair("", null);
    }

    AppProvider.setResendTime(60 * 5);
    if (response.statusCode == 403) {
      AppSharedPreference.removeEmail();
    }
    if (response.statusCode == 422) {
      if (remaining != null) {
        AppProvider.setResendTime(remaining);
        return Pair("يرجى الانتظار لحسن امكانية اعادة طلب الرمز ", null);
      }
    }

    return response.getPairError;
  }
}
