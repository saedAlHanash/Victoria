part of 'governorates_cubit.dart';

class GovernoratesInitial extends AbstractState<List<Governorate>> {
  const GovernoratesInitial({
    required super.result,
    super.error,
    super.request,
    super.filterRequest,
    super.cubitCrud,
    super.createUpdateRequest,
    super.statuses,
    super.id,
  });

  factory GovernoratesInitial.initial() {
    return GovernoratesInitial(
      result: [],
      createUpdateRequest: CreateGovernorateRequest.fromJson({}),
    );
  }

  CreateGovernorateRequest get cRequest => createUpdateRequest;

  String get selectedId => id ?? '';

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

  List<SpinnerItem> getSpinnerItems({String? selectedId}) {
    return List<SpinnerItem>.from(
      result.map(
        (e) => SpinnerItem(
          id: e.id,
          isSelected: e.id.toString() == (selectedId),
          name: e.name,
          item: e,
        ),
      ),
    );
  }

  GovernoratesInitial copyWith({
    CubitStatuses? statuses,
    CubitCrud? cubitCrud,
    List<Governorate>? result,
    String? error,
    FilterRequest? filterRequest,
    dynamic request,
    dynamic cRequest,
    dynamic id,
  }) {
    return GovernoratesInitial(
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
