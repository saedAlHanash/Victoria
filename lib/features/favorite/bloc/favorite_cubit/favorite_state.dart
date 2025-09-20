part of 'favorite_cubit.dart';

class FavoriteInitial extends AbstractState<Favorite> {
  const FavoriteInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
    super.id,
  });

  factory FavoriteInitial.initial() {
    return FavoriteInitial(
      result: Favorite.fromJson({}),
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
      
  FavoriteInitial copyWith({
    CubitStatuses? statuses,
    Favorite? result,
    String? error,
    dynamic id,
    String? request,
  }) {
    return FavoriteInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
      request: request ?? this.request,
    );
  }
}

   