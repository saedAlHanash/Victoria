import 'package:victoria/services/firebase_service.dart';

class LoginRequest {
  String? email;
  String? password;
  String? code;

  LoginRequest({
    this.email,
    this.password,
    this.code,
  });

  LoginRequest copyWith({
    String? email,
    String? password,
  }) {
    return LoginRequest(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Future<Map<String, dynamic>> toJson() async {
    return {
      'email': email,
      'password': password,
      'otp': code,
      'fcm_token': 'no token',
      // 'fcm_token': await FirebaseService.getFireTokenAsync(),
    };
  }
}
