part of 'governorate_cubit.dart';

class GovernorateInitial extends AbstractState<Governorate> {
  const GovernorateInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
    super.id,
  });

  factory GovernorateInitial.initial() {
    return GovernorateInitial(
      result: Governorate.fromJson({}),
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
      
  GovernorateInitial copyWith({
    CubitStatuses? statuses,
    Governorate? result,
    String? error,
    dynamic id,
    String? request,
  }) {
    return GovernorateInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
      request: request ?? this.request,
    );
  }
}

   