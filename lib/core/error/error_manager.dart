import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:m_cubit/abstraction.dart';
import 'package:victoria/core/app/app_provider.dart';
import 'package:victoria/core/extensions/extensions.dart';

import '../../generated/l10n.dart';
import '../app/app_widget.dart';
import '../util/snack_bar_message.dart';

class ErrorManager {
  static String getApiError(Response response) {
    switch (response.statusCode) {
      case 401:
        AppProvider.logout(withDialog: false);

        return ' المستخدم الحالي لم يسجل الدخول ' '${response.statusCode}';

      case 503:
        return 'حدث تغيير في المخدم رمز الخطأ 503 ' '${response.statusCode}';
      case 481:
        return 'لا يوجد اتصال بالانترنت' '${response.statusCode}';
      case 482:
        return ctx == null ? S().noInternet : S.of(ctx!).noInternet;

      case 404:
      case 500:
      default:
        final errorBody = ErrorModel.fromJson(response.jsonBodyPure);
        return errorBody.message;
    }
  }
}

class ErrorModel {
  ErrorModel({
    required this.message,
    this.code = 0,
  });

  final String message;
  final num code;

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('message')) {
      return ErrorModel(
        message: json['message'] ?? '',
        code: json['code'] ?? 0,
      );
    }

    if (json.containsKey('errors') && json['errors'] is List) {
      final errors = json['errors'] as List;
      return ErrorModel(
        message: errors.isNotEmpty ? errors.first.toString() : 'Unknown error',
      );
    }

    return ErrorModel(message: 'Unknown error');
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
      };
}

final shownErrorDialog = <AbstractState>[];

void showErrorFromApi(AbstractState state) {
  if (ctx == null || state.error.contains('لم يسجل الدخول')) return;

  final canShow = shownErrorDialog.firstWhereOrNull((e) => e.error == state.error) == null;

  if (!canShow) return;
  shownErrorDialog.add(state);
  if (shownErrorDialog.isNotEmpty) {
    NoteMessage.showAwesomeError(context: ctx!, message: state.error).then(
      (value) {
        shownErrorDialog.removeWhere((e) => e.error == state.error);
      },
    );
  }
}
