import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:victoria/core/util/shared_preferences.dart';

part 'notification_count_state.dart';

class NotificationCountCubit extends Cubit<NotificationCountInitial> {
  NotificationCountCubit() : super(NotificationCountInitial.initial());

  void changeCount() {
    emit(state.copyWith(result: AppSharedPreference.getNotificationCount()));
  }
}
