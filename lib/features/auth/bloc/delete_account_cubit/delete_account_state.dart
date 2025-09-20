part of 'delete_account_cubit.dart';

class DeleteAccountInitial extends AbstractState<bool> {


  const DeleteAccountInitial({
    required super.statuses,
    required super.result,
    required super.error,
  });

  factory DeleteAccountInitial.initial() {
    return const DeleteAccountInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DeleteAccountInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return DeleteAccountInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
