import '../../../../core/strings/enum_manager.dart';
import '../../../category/data/response/category_response.dart';

class FilterProductRequest {
  FilterProductRequest({
    this.category,
    this.sortBy,
    this.sortOrder,
    this.search,
  });

  Category? category;
  SortBy? sortBy;
  SortOrder? sortOrder;
  String? search;

  factory FilterProductRequest.fromJson(Map<String, dynamic> json) {
    return FilterProductRequest(
      category: json["category_id"],
      sortBy: json["sort_by"] == null ? null : SortBy.values[json["sort_by"] ?? 0],
      sortOrder: json["sort_order"] == null ? null : SortOrder.values[json["sort_order"] ?? 0],
      search: json["search"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "category_id": category?.id,
        "sort_by": sortBy?.nameApi,
        "sort_order": sortOrder?.nameApi,
        "search": search,
      };

  @override
  String toString() {
    return '${category.hashCode}${sortBy.hashCode}${sortOrder.hashCode}${search.hashCode}';
  }

  FilterProductRequest copyWith({
    Category? category,
    SortBy? sortBy,
    SortOrder? sortOrder,
    String? search,
  }) =>
      FilterProductRequest(
        category: category ?? this.category,
        sortBy: sortBy ?? this.sortBy,
        sortOrder: sortOrder ?? this.sortOrder,
        search: search ?? this.search,
      );
}
