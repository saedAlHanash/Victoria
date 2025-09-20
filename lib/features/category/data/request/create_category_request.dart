import '../response/category_response.dart';

class CreateCategoryRequest {
  CreateCategoryRequest({
    required this.id,
  });

  final String id;

  factory CreateCategoryRequest.fromJson(Map<String, dynamic> json) {
    return CreateCategoryRequest(
      id: json["id"] ?? "",
    );
  }

  factory CreateCategoryRequest.fromCategory(Category category) {
    return CreateCategoryRequest(
      id: category.id.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

