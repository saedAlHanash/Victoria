import 'package:m_cubit/m_cubit.dart';
import 'package:victoria/core/api_manager/api_url.dart';
import 'package:victoria/core/app/app_provider.dart';
import 'package:victoria/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/l10n.dart';
import '../../data/request/signup_request.dart';

part 'signup_state.dart';

class SignupCubit extends MCubit<SignupInitial> {
  SignupCubit() : super(SignupInitial.initial());

  @override
  String get nameCache => 'signup';

  Future<void> signup() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _signupApi();

    if (pair.first == null) {
      emit(state.copyWith(error: pair.second, statuses: CubitStatuses.error));
      showErrorFromApi(state);
    } else {
      await AppProvider.cacheEmail(
        email: state.request.email!,
        type: StartPage.signupOtp,
      );

      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _signupApi() async {
    final response = await APIService().callApi(
      url: PostUrl.signup,
      type: ApiType.post,
      body: state.request.toJson(),
    );

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }

  set setName(String? name) {
    state.request.name = name!.trim();
    emit(state.copyWith(request: state.request));
  }

  set setGender(GenderEnum? gender) => state.request.gender = gender;

  set setEducationalGrade(int? id) => state.request.educationalGradeId = id;

  set setBirthday(DateTime? birthday) => state.request.birthday = birthday;

  set setPhone(String? phone) => state.request.phone = phone;
  set setEmail(String? phone) => state.request.email = phone;

  set setPassword(String? password) => state.request.password = password;

  set setRePassword(String? rePassword) => state.request.rePassword = rePassword;

  String? get validateName {
    if (state.request.name.isBlank) {
      return S().nameEmpty;
    }
    return null;
  }

  String? get validateLocation {
    if (state.request.location == null) {
      return '${S().location} ${S().is_required}';
    }
    return null;
  }

  String? get validateBirthday {
    if (state.request.birthday == null) {
      return '${S().birthday} ${S().is_required}';
    }
    return null;
  }

  String? get validatePhone {
    if (state.request.phone.isBlank) {
      return '${S().email} - ${S().phoneNumber}'
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

  String? get validateRePassword {
    if (state.request.rePassword != state.request.password) {
      return S().passwordNotMatch;
    }
    return null;
  }
}
