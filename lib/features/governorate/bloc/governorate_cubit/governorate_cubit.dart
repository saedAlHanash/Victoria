import 'package:m_cubit/abstraction.dart';
import 'package:victoria/core/api_manager/api_service.dart';
import 'package:victoria/core/api_manager/api_url.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/strings/enum_manager.dart';
import 'package:victoria/core/util/pair_class.dart';
import 'package:victoria/features/governorate/data/response/governorate_response.dart';

part 'governorate_state.dart';

class GovernorateCubit extends MCubit<GovernorateInitial> {
  GovernorateCubit() : super(GovernorateInitial.initial());

  @override
  String get nameCache => 'governorate';

  @override
  String get filter => state.filter;

  Future<void> getData({bool newData = false, String? governorateId}) async {
    emit(state.copyWith(request: governorateId));

    await getDataAbstract(
      fromJson: Governorate.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<Governorate?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.governorate,
      query: {'Id': state.request},
    );

    if (response.statusCode.success) {
      return Pair(Governorate.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  void setGovernorate(dynamic governorate) {
    if (governorate is! Governorate) return;

    emit(state.copyWith(result: governorate));
  }
}
