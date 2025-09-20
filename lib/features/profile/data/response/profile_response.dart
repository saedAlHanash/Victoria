import 'package:victoria/core/extensions/extensions.dart';

class Profiles {
  Profiles({
    required this.data,
  });

  final Profile data;

  factory Profiles.fromJson(Map<String, dynamic> json) {
    return Profiles(
      data: Profile.fromJson(json["data"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Profile {
  Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.birthDate,
  });

  final int id;
  final String name;
  final String email;
  final String phone;
  final DateTime? birthDate;

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      birthDate: DateTime.tryParse(json["birth_date"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "birth_date": birthDate?.toIso8601String(),
      };
}
