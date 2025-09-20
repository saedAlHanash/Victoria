import '../../../../core/strings/enum_manager.dart';
import '../../../address/data/response/address_response.dart';
import '../../../product/data/response/product_response.dart';

class Orders {
  Orders({
    required this.data,
  });

  final List<Order> data;

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      data: json["data"] == null ? [] : List<Order>.from(json["data"]!.map((x) => Order.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Order {
  Order({
    required this.id,
    required this.status,
    required this.total,
    required this.deliveryPrice,
    required this.totalWithDeliveryPrice,
    required this.discount,
    required this.products,
    required this.address,
  });

  final int id;
  final OrderStatus status;
  final num total;
  final num deliveryPrice;
  final num totalWithDeliveryPrice;
  final num discount;
  final List<Product> products;
  final Address address;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"] ?? 0,
      status: OrderStatus.getByNameOrIndex(json["status"]?.toString() ?? ""),
      total: json["total"] ?? 0,
      deliveryPrice: json["delivery_price"] ?? 0,
      totalWithDeliveryPrice: json["total_with_delivery_price"] ?? 0,
      discount: json["discount"] ?? 0,
      products: json["product"] == null ? [] : List<Product>.from(json["product"]!.map((x) => Product.fromJson(x))),
      address: Address.fromJson(json["address"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status.index,
        "total": total,
        "delivery_price": deliveryPrice,
        "total_with_delivery_price": totalWithDeliveryPrice,
        "discount": discount,
        "product": products.map((x) => x.toJson()).toList(),
        "address": address.toJson(),
      };
}
