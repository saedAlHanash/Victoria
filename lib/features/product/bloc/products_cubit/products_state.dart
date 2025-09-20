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
  });

  FilterProductRequest get mRequest => request;

  factory ProductsInitial.initial() {
    return ProductsInitial(
      result: [],
      id: 0,
      request: FilterProductRequest.fromJson({}),
      createUpdateRequest: FilterProductRequest.fromJson({}),
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
        if (createUpdateRequest != null) createUpdateRequest!,
      ];

  ProductsInitial copyWith({
    CubitStatuses? statuses,
    CubitCrud? cubitCrud,
    List<Product>? result,
    String? error,
    FilterRequest? filterRequest,
    FilterProductRequest? request,
    int? id,
  }) {
    return ProductsInitial(
      statuses: statuses ?? this.statuses,
      cubitCrud: cubitCrud ?? this.cubitCrud,
      result: result ?? this.result,
      error: error ?? this.error,
      filterRequest: filterRequest ?? this.filterRequest,
      request: request ?? this.request,
      id: id ?? this.id,
    );
  }
}
