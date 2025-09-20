import '../../../../core/strings/enum_manager.dart';

class CouponResponse {
  CouponResponse({
    required this.data,
  });

  final CouponData data;

  factory CouponResponse.fromJson(Map<String, dynamic> json) {
    return CouponResponse(
      data: CouponData.fromJson(json["data"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class CouponData {
  CouponData({
    required this.discount,
    required this.type,
  });

  final String discount;
  final CouponType type;

  factory CouponData.fromJson(Map<String, dynamic> json) {
    return CouponData(
      discount: json["discount"] ?? "",
      type: CouponType.getByNameOrIndex(json["type"] ?? ""),
    );
  }



  Map<String, dynamic> toJson() => {
        "discount": discount,
        "type": type.index,
      };
}
