// import 'package:http/http.dart';
// import 'package:m_cubit/m_cubit.dart';
// import 'package:victoria/core/api_manager/api_service.dart';
// import 'package:victoria/core/api_manager/api_url.dart';
// import 'package:victoria/core/extensions/extensions.dart';
// import 'package:victoria/core/strings/enum_manager.dart';
// import 'package:victoria/core/util/pair_class.dart';
// import 'package:victoria/features/ads/data/request/create_ads_request.dart';
// import 'package:victoria/features/ads/data/response/ads_response.dart';
//
// import '../../../../core/error/error_manager.dart';
//
// part 'banners_state.dart';
//
// class BannersCubit extends MCubit<BannersInitial> {
//   BannersCubit() : super(BannersInitial.initial());
//
//   @override
//   String get nameCache => 'banners';
//
//   @override
//   String get filter => state.filter;
//
//   //region getData
//
//   void getDataFromCache() => getFromCache(
//         fromJson: Ads.fromJson,
//         state: state,
//         onSuccess: (data) => emit(state.copyWith(result: data)),
//       );
//
//   Future<void> getData({bool newData = false}) async {
//     await getDataAbstract(
//       fromJson: Ads.fromJson,
//       state: state,
//       getDataApi: _getData,
//       newData: newData,
//     );
//   }
//
//   Future<Pair<List<Ads>?, String?>> _getData() async {
//     final response = await APIService().callApi(
//       type: ApiType.get,
//       url: GetUrl.adss,
//       query: {'type': 'banner'},
//     );
//
//     if (response.statusCode.success) {
//       return Pair(Adss.fromJson(response.jsonBody).data, null);
//     } else {
//       return response.getPairError;
//     }
//   }
//
//   //endregion
//
//   //region CRUD
//   Future<void> create() async {
//     emit(state.copyWith(statuses: CubitStatuses.loading, cubitCrud: CubitCrud.create));
//
//     final response = await APIService().callApi(
//       type: ApiType.post,
//       url: PostUrl.createAds,
//       body: state.cRequest.toJson(),
//     );
//
//     await _updateState(response);
//   }
//
//   Future<void> update() async {
//     emit(state.copyWith(statuses: CubitStatuses.loading, cubitCrud: CubitCrud.update));
//
//     final response = await APIService().callApi(
//       type: ApiType.put,
//       url: PutUrl.updateAds,
//       query: {'id': state.cRequest.id},
//       body: state.cRequest.toJson(),
//     );
//     await _updateState(response);
//   }
//
//   Future<void> delete({required String id}) async {
//     emit(state.copyWith(statuses: CubitStatuses.loading, cubitCrud: CubitCrud.delete, id: id));
//
//     final response = await APIService().callApi(
//       type: ApiType.delete,
//       url: DeleteUrl.deleteAds,
//       query: {'id': state.id.toString()},
//     );
//
//     await _updateState(response, isDelete: true);
//   }
//
//   Future<void> deleteNow({required String id}) async {
//     final index = state.result.indexWhere((element) => element.id.toString() == id);
//     final item = state.result.removeAt(index);
//
//     emit(state.copyWith(cubitCrud: CubitCrud.delete, result: state.result, id: id));
//
//     final response = await APIService().callApi(
//       type: ApiType.delete,
//       url: DeleteUrl.deleteAds,
//       query: {'id': state.id.toString()},
//     );
//
//     if (response.statusCode.success) {
//       await deleteAdsFromCache(item.id.toString());
//     } else {
//       showErrorFromApi(state);
//       state.result.insert(index, item);
//       emit(state.copyWith(statuses: CubitStatuses.error, result: state.result));
//     }
//   }
//
//   Future<void> _updateState(Response response, {bool isDelete = false}) async {
//     if (response.statusCode.success) {
//       final item = Ads.fromJson(response.jsonBody);
//       isDelete ? await deleteAdsFromCache(state.id.toString()) : await addOrUpdateAdsToCache(item);
//       emit(state.copyWith(statuses: CubitStatuses.done));
//     } else {
//       emit(state.copyWith(statuses: CubitStatuses.error, error: response.getPairError.second));
//       showErrorFromApi(state);
//     }
//   }
//
//   //endregion
//
//   Future<void> addOrUpdateAdsToCache(Ads item) async {
//     final listJson = await addOrUpdateDate([item]);
//     if (listJson == null) return;
//     final list = listJson.map((e) => Ads.fromJson(e)).toList();
//     emit(state.copyWith(result: list));
//   }
//
//   Future<void> deleteAdsFromCache(String id) async {
//     final listJson = await deleteDate([id]);
//     if (listJson == null) return;
//     final list = listJson.map((e) => Ads.fromJson(e)).toList();
//     emit(state.copyWith(result: list));
//   }
// }
