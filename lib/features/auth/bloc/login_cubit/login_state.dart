part of 'login_cubit.dart';

class LoginInitial extends AbstractState<LoginResponse> {
  @override
  final LoginRequest request;

  const LoginInitial({required super.result, super.error, required this.request, super.statuses});

  factory LoginInitial.initial() {
    return LoginInitial(
      result: LoginResponse.fromJson({}),
      error: '',
      request: LoginRequest(),
      statuses: CubitStatuses.init,
    );
  }

  bool get canSend => !request.phone.isBlank && !request.password.isBlank;

  @override
  List<Object> get props => [statuses, result, error];

  LoginInitial copyWith({CubitStatuses? statuses, LoginResponse? result, String? error, LoginRequest? request}) {
    return LoginInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
