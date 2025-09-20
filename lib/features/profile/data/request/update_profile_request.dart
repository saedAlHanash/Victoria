import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:victoria/core/app/app_provider.dart';
import 'package:victoria/core/app/app_provider.dart';

import '../../../../core/strings/enum_manager.dart';

class UpdateProfileRequest {
  UpdateProfileRequest({
    this.name,
    // this.birthday,
    this.phone,
    this.email,
  });

  String? name;
  String? phone;
  String? email;

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) {
    return UpdateProfileRequest(
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        if (phone != AppProvider.getMe.phone) 'phone': phone,
        if (email != AppProvider.getMe.email) 'email': email,
      };
}
