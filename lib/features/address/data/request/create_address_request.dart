import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../governorate/data/response/governorate_response.dart';

class CreateAddressRequest {
  CreateAddressRequest({
    required this.id,
    required this.governorate,
    required this.name,
    required this.longitude,
    required this.latitude,
  });

  int id;
  Governorate governorate;
  String name;
  num longitude;
  num latitude;

  factory CreateAddressRequest.fromJson(Map<String, dynamic> json) {
    return CreateAddressRequest(
      id: json["id"] ?? 0,
      governorate: Governorate.fromJson({}),
      name: json["name"] ?? '',
      longitude: json["longitude"] ?? 0,
      latitude: json["latitude"] ?? 0,
    );
  }

  LatLng get getLatLng => (latitude == 0 && longitude == 0)
      ? governorate.iraqGovernorate.getGovernorateLatLng
      : LatLng(latitude.toDouble(), longitude.toDouble());

  Map<String, dynamic> toJson() => {
        "id": id,
        "governorate_id": governorate.id,
        "name": name,
        "longitude": longitude,
        "latitude": latitude,
      };
}
