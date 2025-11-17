import 'package:m_cubit/m_cubit.dart';
import 'package:victoria/core/api_manager/api_url.dart';
import 'package:victoria/core/app/app_provider.dart';
import 'package:victoria/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/notification_response.dart';

part 'all_notification_state.dart';

class NotificationCubit extends MCubit<NotificationsInitial> {
  NotificationCubit() : super(NotificationsInitial.initial());

  @override
  String get nameCache => 'notifications';

  @override
  String get filter => '';

  Future<void> getData({bool newData = false}) async {
    if (AppProvider.isNotLogin) return;

    getDataAbstract(
      fromJson: NotificationModel.fromJson,
      state: state,
      getDataApi: _getDataApi,
      newData: newData,
    );
  }

  Future<void> readAll() async {
    if (AppProvider.isNotLogin) return;

    await APIService().callApi(
      type: ApiType.put,
      url: 'notification/read-all',
    );
  }

  Future<Pair<List<NotificationModel>?, String?>> _getDataApi() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.getAllNotifications,
    );

    if (response.statusCode.success) {
      return Pair(NotificationsResponse.fromJson(response.jsonBodyPure).data, null);
    } else {
      return response.getPairError;
    }
  }
}
