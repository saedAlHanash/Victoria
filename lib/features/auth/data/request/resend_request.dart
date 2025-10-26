import '../../../../core/util/shared_preferences.dart';

class ResendRequest {
  ResendRequest({this.phone});

  String? phone;

  factory ResendRequest.fromJson(Map<String, dynamic> json) {
    return ResendRequest(phone: json["phone"] ?? "");
  }

  Map<String, dynamic> toJson() => {"phone": phone ?? AppSharedPreference.getEmail};
}
