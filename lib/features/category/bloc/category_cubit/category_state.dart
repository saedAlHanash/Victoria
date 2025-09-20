part of 'category_cubit.dart';

class CategoryInitial extends AbstractState<Category> {
  const CategoryInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
    super.id,
  });

  factory CategoryInitial.initial() {
    return CategoryInitial(
      result: Category.fromJson({}),
      request: '',
      
    );
  }

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        if (request != null) request,
        if (id != null) id,
        if (filterRequest != null) filterRequest!,
      ];
      
  CategoryInitial copyWith({
    CubitStatuses? statuses,
    Category? result,
    String? error,
    dynamic id,
    String? request,
  }) {
    return CategoryInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
      request: request ?? this.request,
    );
  }
}

   