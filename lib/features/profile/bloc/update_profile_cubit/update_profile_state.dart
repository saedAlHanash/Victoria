part of 'update_profile_cubit.dart';

class UpdateProfileInitial extends AbstractState<Profile> {
  UpdateProfileRequest get mRequest => request as UpdateProfileRequest;

  // final  bool educationalGradeParam;
  const UpdateProfileInitial({
    required super.result,
    super.error,
    super.request,
    super.statuses,
  }); //

  factory UpdateProfileInitial.initial() {
    return UpdateProfileInitial(
      result: Profile.fromJson({}),
      error: '',
      // educationalGradeParam: false,
      request: UpdateProfileRequest.fromJson(AppProvider.getMe.toJson()),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  UpdateProfileInitial copyWith(
      {CubitStatuses? statuses,
      Profile? result,
      String? error,
      UpdateProfileRequest? request}) {
    return UpdateProfileInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
