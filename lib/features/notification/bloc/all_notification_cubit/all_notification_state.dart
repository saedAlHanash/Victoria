part of 'all_notification_cubit.dart';

class NotificationsInitial extends AbstractState<List<NotificationModel>> {
  final int id;

  const NotificationsInitial({
    required super.result,
    super.error,
    required this.id,
    super.statuses,
  }); //

  factory NotificationsInitial.initial() {
    return const NotificationsInitial(
      result: [],
      error: '',
      id: 0,
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  NotificationsInitial copyWith({
    CubitStatuses? statuses,
    List<NotificationModel>? result,
    String? error,
    int? id,
  }) {
    return NotificationsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
    );
  }
}
