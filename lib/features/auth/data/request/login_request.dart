import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/services/firebase_service.dart';

class LoginRequest {
  String? phone;
  String? password;
  String? code;

  LoginRequest({this.phone, this.password, this.code});

  LoginRequest copyWith({String? phone, String? password}) {
    return LoginRequest(phone: phone ?? this.phone, password: password ?? this.password);
  }

  Future<Map<String, dynamic>> toJson() async {
    return {
      'phone': phone.fixPhone,
      'password': password,
      'otp': code,
      'fcm_token': 'no token',
      // 'fcm_token': await FirebaseService.getFireTokenAsync(),
    };
  }
}
