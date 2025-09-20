import 'package:m_cubit/abstraction.dart';
import 'package:victoria/core/api_manager/api_service.dart';
import 'package:victoria/core/api_manager/api_url.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/strings/enum_manager.dart';
import 'package:victoria/core/util/pair_class.dart';
import 'package:victoria/features/ads/data/response/ads_response.dart';

part 'ads_state.dart';

class AdsCubit extends MCubit<AdsInitial> {
  AdsCubit() : super(AdsInitial.initial());

  @override
  String get nameCache => 'ads';

  @override
  String get filter => state.filter;

  Future<void> getData({bool newData = false, String? adsId}) async {
    emit(state.copyWith(request: adsId));

    await getDataAbstract(
      fromJson: Ads.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<Ads?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.ads,
      query: {'Id': state.request},
    );

    if (response.statusCode.success) {
      return Pair(Ads.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  void setAds(dynamic ads) {
    if (ads is! Ads) return;

    emit(state.copyWith(result: ads));
  }
}
