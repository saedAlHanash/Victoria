import '../../../../core/util/shared_preferences.dart';

class ResendRequest {
  ResendRequest({
    this.email,
  });

  String? email;

  factory ResendRequest.fromJson(Map<String, dynamic> json) {
    return ResendRequest(
      email: json["email"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email ?? AppSharedPreference.getEmail,
      };
}
