part of 'get_me_cubit.dart';

class GetMeInitial extends AbstractState<Profile> {
  // final ProfileRequest request;
  // final  bool educationalGradeParam;
  const GetMeInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.educationalGradeParam,
    super.statuses,
  }); //

  factory GetMeInitial.initial() {
    return GetMeInitial(
      result: Profile.fromJson({}),
      error: '',
      // educationalGradeParam: false,
      // request: ProfileRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
      ];

  GetMeInitial copyWith({
    CubitStatuses? statuses,
    Profile? result,
    String? error,
  }) {
    return GetMeInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
