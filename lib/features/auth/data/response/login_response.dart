import '../../../profile/data/response/profile_response.dart';

class LoginResponse {
  LoginResponse({
    required this.user,
    required this.token,
  });

  final Profile user;
  final String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: Profile.fromJson(json["data"] ?? {}),
      token: json["token"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "data": user?.toJson(),
        "token": token,
      };
}
