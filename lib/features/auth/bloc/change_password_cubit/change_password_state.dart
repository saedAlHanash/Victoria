part of 'change_password_cubit.dart';

class ChangePasswordInitial extends AbstractState<bool> {
  const ChangePasswordInitial({
    required super.result,
    super.error,
    super.statuses,
  });

  factory ChangePasswordInitial.initial() {
    return const ChangePasswordInitial(result: false);
  }

  @override
  List<Object> get props => [statuses, result, error];

  ChangePasswordInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return ChangePasswordInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
