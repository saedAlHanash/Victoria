class PaginationMeta {
  PaginationMeta({
     this.currentPage=1,
    required this.lastPage,
    this.perPage = 20,
    required this.total,
  });

  int currentPage;
  final int lastPage;
  int perPage;
  final int total;

  bool get haveNext => currentPage < lastPage;

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      currentPage: json["page"] ?? 1,
      lastPage: json["lastPage"] ?? 0,
      perPage: json["perPage"] ?? 20,
      total: json["total"] ?? 0,
    );
  }

  PaginationMeta get next => this..currentPage += 1;

  Map<String, dynamic> toJson() => {
    "page": currentPage,
    "lastPage": lastPage,
    "perPage": perPage,
    "total": total,
  };

  Map<String, dynamic> toJsonNext() => {
    "page": currentPage,
    "perPage": perPage,
  };
}
