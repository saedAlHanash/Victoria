part of 'categories_cubit.dart';

class CategoriesInitial extends AbstractState<List<Category>> {
  const CategoriesInitial({
    required super.result,
    super.error,
    super.request,
    super.filterRequest,
    super.cubitCrud,
    super.createUpdateRequest,
    super.statuses,
    super.id,
  });

  factory CategoriesInitial.initial() {
    return CategoriesInitial(
      result: [],
      createUpdateRequest: CreateCategoryRequest.fromJson({}),
    );
  }

  CreateCategoryRequest get cRequest => createUpdateRequest;

  String get mId => id ?? '';

  Category get mRequest => request ?? Category.fromJson({});

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

  CategoriesInitial copyWith({
    CubitStatuses? statuses,
    CubitCrud? cubitCrud,
    List<Category>? result,
    String? error,
    FilterRequest? filterRequest,
    dynamic request,
    dynamic cRequest,
    dynamic id,
  }) {
    return CategoriesInitial(
      statuses: statuses ?? this.statuses,
      cubitCrud: cubitCrud ?? this.cubitCrud,
      result: result ?? this.result,
      error: error ?? this.error,
      filterRequest: filterRequest ?? this.filterRequest,
      request: request ?? this.request,
      createUpdateRequest: cRequest ?? this.cRequest,
      id: id ?? this.id,
    );
  }
}
