

class Favorites {
  Favorites({
    required this.data,
  });

  final List<Favorite> data;

  factory Favorites.fromJson(Map<String, dynamic> json) {
    return Favorites(
      data: json["data"] == null
          ? []
          : List<Favorite>.from(json["data"]!.map((x) => Favorite.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data.map((x) => x.toJson()).toList(),
  };
}

class Favorite {
  Favorite({
    required this.id,
    required this.productId,
    required this.name,
    required this.thumbnail,
    required this.price,
    required this.discountPrice,
  });

  final int id;
  final int productId;
  final String name;
  final String thumbnail;
  final String price;
  final String discountPrice;

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: int.tryParse(json["product_id"].toString()) ?? 0,
      productId: int.tryParse(json["product_id"].toString()) ?? 0,
      name: json["name"] ?? "",
      thumbnail: json["thumbnail"] ?? "",
      price: json["price"] ?? "",
      discountPrice: json["discount_price"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "name": name,
    "thumbnail": thumbnail,
    "price": price,
    "discount_price": discountPrice,
  };
}
