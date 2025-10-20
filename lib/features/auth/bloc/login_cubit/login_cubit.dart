import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:victoria/core/api_manager/api_url.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/features/auth/data/request/login_request.dart';
import 'package:victoria/services/firebase_service.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/app/app_widget.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../data/response/login_response.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginInitial> {
  LoginCubit() : super(LoginInitial.initial());

  Future<void> login() async {
    // await FirebaseService.getFireTokenAsync();
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _loginApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await AppProvider.login(response: pair.first!);

      CachingService.setSupperFilter(AppProvider.supperFilter);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<LoginResponse?, String?>> _loginApi() async {
    loggerObject.w('message');
    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.loginUrl,
      body: await state.request.toJson(),
    );
    loggerObject.w('message');
    if (response.statusCode.success) {
      final pair = Pair(LoginResponse.fromJson(response.jsonBody), null);

      return pair;
    } else {
      if (response.statusCode == 311) {
        await AppProvider.cacheEmail(phone: state.request.phone!, type: StartPage.signupOtp);

        Navigator.pushNamed(ctx!, RouteName.confirmCode);
      }
      return response.getPairError as Pair<LoginResponse?, String?>;
    }
  }

  set setPhone(String? phone) => state.request.phone = phone;

  set setPassword(String? password) => state.request.password = password;

  String? get validatePhone {
    if (state.request.phone.isBlank) {
      return '${S().phoneNumber}'
          ' ${S().is_required}';
    }
    return null;
  }

  String? get validatePassword {
    if (state.request.password.isBlank) {
      return '${S().password} ${S().is_required}';
    }
    return null;
  }
}
