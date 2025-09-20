part of 'resend_code_cubit.dart';

class ResendCodeInitial extends AbstractState<String> {
  const ResendCodeInitial({
    required super.result,
    super.error,
    super.statuses,
    super.request,
  });

  ResendRequest get mRequest => request;

  factory ResendCodeInitial.initial() {
    return const ResendCodeInitial(
      result: '',
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error, if (request != null) request];

  ResendCodeInitial copyWith({
    CubitStatuses? statuses,
    String? result,
    String? error,
    ResendRequest? request,
  }) {
    return ResendCodeInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
