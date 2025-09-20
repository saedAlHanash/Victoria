part of 'signup_cubit.dart';

class SignupInitial extends AbstractState<bool> {
  @override
  final SignupRequest request;

  const SignupInitial({
    required this.request,
    required super.result,
    super.error,
    super.statuses,
  });

  factory SignupInitial.initial() {
    return SignupInitial(
      result: false,
      request: SignupRequest(),
    );
  }

  bool get canSend {
    return !request.name.isBlank &&
        request.location != null &&
        request.gender != null &&
        request.birthday != null &&
        !request.phone.isBlank &&
        !request.password.isBlank &&
        !request.rePassword.isBlank &&
        request.password == request.rePassword &&
        request.governorateId != null &&
        request.educationalGradeId != null;
  }

  @override
  List<Object> get props => [statuses, result, error];

  SignupInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    SignupRequest? request,
  }) {
    return SignupInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
