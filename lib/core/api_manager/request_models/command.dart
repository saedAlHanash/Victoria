import 'package:victoria/core/extensions/extensions.dart';

class PaginationMeta {
  PaginationMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  int currentPage;
  final int lastPage;
  int perPage;
  final int total;

  bool get haveNext => currentPage < lastPage;

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      currentPage: json["page"] ?? json["current_page"] ?? 1,
      lastPage: json["lastPage"] ?? json["last_page"] ?? 0,
      perPage: json["perPage"] ?? json["per_page"] ?? 0,
      total: json["total"] ?? json["total"] ?? 0,
    );
  }

  PaginationMeta get next => this..currentPage += 1;

  Map<String, dynamic> toJson() => {
        "current_page": currentPage.isBlankNumber ? 1 : currentPage,
        "last_page": lastPage,
        "per_page": perPage.isBlankNumber ? 20.0 : perPage,
        "total": total,
      };

  Map<String, dynamic> toJsonNext() => {
        "current_page": currentPage.isBlankNumber ? 1 : currentPage,
        "per_page": perPage.isBlankNumber ? 20.0 : perPage,
      };
}
