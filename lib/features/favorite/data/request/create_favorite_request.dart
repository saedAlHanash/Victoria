import '../response/favorite_response.dart';

class CreateFavoriteRequest {
  CreateFavoriteRequest({
    required this.id,
  });

  final String id;

  factory CreateFavoriteRequest.fromJson(Map<String, dynamic> json) {
    return CreateFavoriteRequest(
      id: json["id"] ?? "",
    );
  }

  factory CreateFavoriteRequest.fromFavorite(Favorite favorite) {
    return CreateFavoriteRequest(
      id: favorite.id.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

