import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/strings/enum_manager.dart';

class Governorates {
  Governorates({
    required this.data,
  });

  final List<Governorate> data;

  factory Governorates.fromJson(Map<String, dynamic> json) {
    return Governorates(
      data: json["data"] == null ? [] : List<Governorate>.from(json["data"]!.map((x) => Governorate.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Governorate {
  Governorate({
    required this.id,
    required this.name,
    required this.deliveryPrice,
    required this.iraqGovernorate,
  });

  final int id;
  final String name;
  final num deliveryPrice;
  final IraqGovernorate iraqGovernorate;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "delivery_price": deliveryPrice,
    };
  }

  factory Governorate.fromJson(Map<String, dynamic> json) {
    return Governorate(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      deliveryPrice: (json["delivery_price"] ?? "0").toString().tryParseOrZero,
      iraqGovernorate: IraqGovernorate.getByApproximateName(json["name"] ?? ""),
    );
  }
}
