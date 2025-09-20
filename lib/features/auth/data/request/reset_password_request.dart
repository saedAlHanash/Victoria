import 'package:victoria/core/extensions/extensions.dart';

import '../../../../core/app/app_provider.dart';

class ResetPasswordRequest {
  ResetPasswordRequest({
    this.password,
    this.passwordConfirmation,
    this.code,
  });

  String? password;
  String? passwordConfirmation;
  String? code;

  Map<String, dynamic> toJson() => {
        "phone": AppProvider.getPhoneCached.fixPhone,
        "password": password,
        "token": code,
      };
}
