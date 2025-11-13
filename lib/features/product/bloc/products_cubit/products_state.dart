part of 'products_cubit.dart';

class ProductsInitial extends AbstractState<List<Product>> {
  const ProductsInitial({
    required super.result,
    super.error,
    super.request,
    super.filterRequest,
    super.cubitCrud,
    super.createUpdateRequest,
    super.statuses,
    super.id,
    required this.meta,
  });

  final PaginationMeta meta;

  SearchRequest get mRequest => request;

  factory ProductsInitial.initial() {
    return ProductsInitial(
      result: [],
      id: 0,
      request: SearchRequest.fromJson({}),
      createUpdateRequest: SearchRequest.fromJson({}),
      meta: PaginationMeta.fromJson({}),
    );
  }

  int get mId => id ?? 0;

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        cubitCrud,
        if (id != null) id,
        if (request != null) request,
        if (filterRequest != null) filterRequest!,
        meta,
        if (createUpdateRequest != null) createUpdateRequest!,
      ];

  ProductsInitial copyWith({
    CubitStatuses? statuses,
    CubitCrud? cubitCrud,
    List<Product>? result,
    String? error,
    FilterRequest? filterRequest,
    SearchRequest? request,
    int? id,
    PaginationMeta? meta,
  }) {
    return ProductsInitial(
      statuses: statuses ?? this.statuses,
      cubitCrud: cubitCrud ?? this.cubitCrud,
      result: result ?? this.result,
      error: error ?? this.error,
      filterRequest: filterRequest ?? this.filterRequest,
      request: request ?? this.request,
      id: id ?? this.id,
      meta: meta ?? this.meta,
    );
  }
}
