part of 'adss_cubit.dart';

class AdssInitial extends AbstractState<List<Ads>> {
  const AdssInitial({
    required super.result,
    super.error,
    super.request,
    super.filterRequest,
    super.cubitCrud,
    super.createUpdateRequest,
    super.statuses,
    super.id,
  });

  factory AdssInitial.initial() {
    return  AdssInitial(
      result: [],
      createUpdateRequest: CreateAdsRequest.fromJson({}),
    );
  }

  CreateAdsRequest get cRequest => createUpdateRequest;

  String get mId => id;

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

  AdssInitial copyWith({
    CubitStatuses? statuses,
    CubitCrud? cubitCrud,
    List<Ads>? result,
    String? error,
    FilterRequest? filterRequest,
    dynamic request,
    dynamic cRequest,
    dynamic id,
  }) {
    return AdssInitial(
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

