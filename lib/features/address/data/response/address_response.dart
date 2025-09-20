import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/extensions/extensions.dart';

import '../../../governorate/data/response/governorate_response.dart';

class Addresses {
  Addresses({
    required this.data,
  });

  final List<Address> data;

  factory Addresses.fromJson(Map<String, dynamic> json) {
    return Addresses(
      data: json["data"] == null ? [] : List<Address>.from(json["data"]!.map((x) => Address.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Address {
  Address({
    required this.id,
    required this.governorate,
    required this.longitude,
    required this.name,
    required this.latitude,
  });

  final int id;
  final Governorate governorate;
  final num longitude;
  final String name;
  final num latitude;

  LatLng get getLatLng => LatLng(latitude.toDouble() ?? 0, longitude.toDouble() ?? 0);

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json["id"] ?? 0,
      governorate: Governorate.fromJson(json["governorate"] ?? {}),
      longitude: (json["longitude"] ?? "").toString().tryParseOrZero,
      name: json["name"] ?? "",
      latitude: (json["latitude"] ?? "").toString().tryParseOrZero,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "governorate": governorate.toJson(),
        "longitude": longitude,
        "name": name,
        "latitude": latitude,
      };
}
