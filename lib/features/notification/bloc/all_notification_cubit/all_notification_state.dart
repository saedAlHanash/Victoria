part of 'all_notification_cubit.dart';

class NotificationsInitial extends AbstractState<List<NotificationModel>> {
  const NotificationsInitial({
    required super.result,
    super.error,
    super.statuses,
  }); //

  factory NotificationsInitial.initial() {
    return const NotificationsInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  NotificationsInitial copyWith({
    CubitStatuses? statuses,
    List<NotificationModel>? result,
    String? error,
  }) {
    return NotificationsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
