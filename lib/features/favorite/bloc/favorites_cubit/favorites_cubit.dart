import 'package:http/http.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:victoria/core/api_manager/api_service.dart';
import 'package:victoria/core/api_manager/api_url.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/strings/enum_manager.dart';
import 'package:victoria/core/util/pair_class.dart';
import 'package:victoria/features/favorite/data/request/create_favorite_request.dart';
import 'package:victoria/features/favorite/data/response/favorite_response.dart';
import 'package:victoria/features/product/data/response/product_response.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../core/error/error_manager.dart';

part 'favorites_state.dart';

class FavoritesCubit extends MCubit<FavoritesInitial> {
  FavoritesCubit() : super(FavoritesInitial.initial());

  @override
  String get nameCache => 'favorites';

  @override
  String get filter => state.filter;

  //region getData

  void getDataFromCache() => getFromCache(
        fromJson: Product.fromJson,
        state: state,
        onSuccess: (data) {
          emit(state.copyWith(result: data));
        },
      );

  Future<void> getData({bool newData = false}) async {
    if (AppProvider.isGuest) return;
    await getDataAbstract(
      fromJson: Product.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<List<Product>?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: PostUrl.favorites,
      body: state.filterRequest?.toJson() ?? {},
    );

    if (response.statusCode.success) {
      return Pair(Products.fromJsonFav(response.jsonBody).data, null);
    } else {
      return response.getPairError;
    }
  }

  //endregion

  //region CRUD
  Future<void> toggleFavorite(Product product) async {
    emit(state.copyWith(
      statuses: CubitStatuses.loading,
      cubitCrud: CubitCrud.create,
      id: product.id,
    ));

    final response = await APIService().callApi(
      type: ApiType.put,
      url: PostUrl.toggleFav,
      path: state.mId,
    );

    await _updateState(response, item: product, isDelete: state.result.any((e) => e.id == product.id));
  }

  Future<void> deleteNow({required String id}) async {
    final index = state.result.indexWhere((element) => element.id.toString() == id);
    final item = state.result.removeAt(index);

    emit(state.copyWith(cubitCrud: CubitCrud.delete, result: state.result, id: id));

    final response = await APIService().callApi(
      type: ApiType.delete,
      url: DeleteUrl.deleteFavorite,
      query: {'id': state.id.toString()},
    );

    if (response.statusCode.success) {
      await deleteFavoriteFromCache(item.id.toString());
    } else {
      showErrorFromApi(state);
      state.result.insert(index, item);
      emit(state.copyWith(statuses: CubitStatuses.error, result: state.result));
    }
  }

  Future<void> _updateState(Response response, {required Product item, bool isDelete = false}) async {
    if (response.statusCode.success) {
      isDelete ? await deleteFavoriteFromCache(state.id.toString()) : await addOrUpdateFavoriteToCache(item);
      emit(state.copyWith(statuses: CubitStatuses.done));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.error, error: response.getPairError.second));
      showErrorFromApi(state);
    }
  }

  //endregion

  Future<void> addOrUpdateFavoriteToCache(Product item) async {
    final listJson = await addOrUpdateDate([item]);
    if (listJson == null) return;
    final list = listJson.map((e) => Product.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }

  Future<void> deleteFavoriteFromCache(String id) async {
    final listJson = await deleteDate([id]);
    if (listJson == null) return;
    final list = listJson.map((e) => Product.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }
}
