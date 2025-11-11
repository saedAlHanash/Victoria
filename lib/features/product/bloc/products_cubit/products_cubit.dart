import 'package:m_cubit/m_cubit.dart';
import 'package:victoria/core/api_manager/api_service.dart';
import 'package:victoria/core/api_manager/api_url.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/strings/enum_manager.dart';
import 'package:victoria/core/util/pair_class.dart';
import 'package:victoria/features/product/data/request/filter_product_request.dart';
import 'package:victoria/features/product/data/response/product_response.dart';

import '../../../../core/api_manager/request_models/command.dart';
import '../../../category/data/response/category_response.dart';

part 'products_state.dart';

class ProductsCubit extends MCubit<ProductsInitial> {
  ProductsCubit() : super(ProductsInitial.initial());

  @override
  String get nameCache => 'products';

  @override
  String get filter => state.filter;

  PaginationMeta? _meta;

  //region getData

  void getDataFromCache() => getFromCache(
        fromJson: Product.fromJson,
        state: state,
        onSuccess: (data) {
          emit(state.copyWith(result: data));
        },
      );

  Future<void> getData({bool newData = false, GetProductsType? type}) async {
    emit(state.copyWith(id: type?.index));
    await getDataAbstract(
      fromJson: Product.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<void> getNextPage() async {
    if (!state.meta.haveNext) return;
    emit(state.copyWith(statuses: CubitStatuses.noLoading, meta: state.meta.next));
    final pair = await _getData();
    if (pair.first != null) {
      emit(state.copyWith(
        result: [...state.result, ...(pair.first!)],
        meta: _meta,
        statuses: CubitStatuses.done,
      ));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.error));
    }
  }

  Future<Pair<List<Product>?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: PostUrl.products(state.mId),
      query: state.mRequest.toJson(),
    );

    if (response.statusCode.success) {
      return Pair(Products.fromJson(response.jsonBody).data, null);
    } else {
      return response.getPairError;
    }
  }

  //endregion

  void setFilterRequest(FilterProductRequest? request) {
    emit(state.copyWith(request: request));
  }

  void setCategory(Category category) {
    if (category.id == state.mRequest.category?.id) {
      emit(state.copyWith(request: state.mRequest..category = null));
      getData();
      return;
    }

    emit(state.copyWith(request: state.mRequest..category = category));
    getData();
  }

  void setSearch(String? search) {
    emit(state.copyWith(request: state.mRequest..search = search));
  }

  void setSortBy(SortBy? sortBy) {
    emit(state.copyWith(request: state.mRequest..sortBy = sortBy));
    getData();
  }

  void setSortOrder(SortOrder? sortOrder) {
    emit(state.copyWith(request: state.mRequest..sortOrder = sortOrder));
    getData();
  }

  Future<void> addOrUpdateProductToCache(Product item) async {
    final listJson = await addOrUpdateDate([item]);
    if (listJson == null) return;
    final list = listJson.map((e) => Product.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }

  Future<void> deleteProductFromCache(String id) async {
    final listJson = await deleteDate([id]);
    if (listJson == null) return;
    final list = listJson.map((e) => Product.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }
}
