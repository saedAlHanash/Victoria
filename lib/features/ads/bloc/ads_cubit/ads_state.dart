part of 'ads_cubit.dart';

class AdsInitial extends AbstractState<Ads> {
  const AdsInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
    super.id,
  });

  factory AdsInitial.initial() {
    return AdsInitial(
      result: Ads.fromJson({}),
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
      
  AdsInitial copyWith({
    CubitStatuses? statuses,
    Ads? result,
    String? error,
    dynamic id,
    String? request,
  }) {
    return AdsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
      request: request ?? this.request,
    );
  }
}

   