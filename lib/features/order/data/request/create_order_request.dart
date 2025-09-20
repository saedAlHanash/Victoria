import '../../../address/data/response/address_response.dart';
import '../response/order_response.dart';

class CreateOrderRequest {
  CreateOrderRequest({
    required this.products,
    required this.couponCode,
    required this.address,
  });

  List<ProductDto> products;
  String couponCode;
  Address address;

  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) {
    return CreateOrderRequest(
      products: json["products"] == null ? [] : List<ProductDto>.from(json["products"]!.map((x) => ProductDto.fromJson(x))),
      couponCode: json["coupon_code"] ?? "",
      address: Address.fromJson(json["address_id"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "products": products.map((x) => x.toJson()).toList(),
        "coupon_code": couponCode,
        "address_id": address.id,
      };
}

class ProductDto {
  ProductDto({
    required this.id,
    required this.quantity,
  });

  final int id;
  final num quantity;

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      id: json["id"] ?? 0,
      quantity: json["quantity"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
      };
}
