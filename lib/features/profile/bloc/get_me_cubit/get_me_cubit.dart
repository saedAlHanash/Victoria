import 'package:m_cubit/m_cubit.dart';
import 'package:victoria/core/api_manager/api_url.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/util/shared_preferences.dart';
import 'package:victoria/features/profile/data/response/profile_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

part 'get_me_state.dart';

class GetMeCubit extends MCubit<GetMeInitial> {
  GetMeCubit() : super(GetMeInitial.initial());

  @override
  String get nameCache => 'profile';

  Future<void> getData({bool newData = false}) async {
    if (AppProvider.isGuest) return;
    getDataAbstract(
      fromJson: Profile.fromJson,
      state: state,
      getDataApi: _getDataApi,
      onSuccess: (data, emitState) async {
        await AppSharedPreference.cashUser(data);
        emit(state.copyWith(statuses: emitState, result: data));
      },
      newData: newData,
    );
  }

  Future<Pair<Profile?, String?>> _getDataApi() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.profile,
    );

    if (response.statusCode.success) {
      final pair = Pair(Profiles.fromJson(response.jsonBodyPure).data, null);
      return pair;
    } else {
      return response.getPairError;
    }
  }
}
