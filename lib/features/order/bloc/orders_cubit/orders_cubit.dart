import 'package:http/http.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:victoria/core/api_manager/api_service.dart';
import 'package:victoria/core/api_manager/api_url.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/strings/enum_manager.dart';
import 'package:victoria/core/util/pair_class.dart';
import 'package:victoria/features/order/data/request/create_order_request.dart';
import 'package:victoria/features/order/data/response/order_response.dart';

import '../../../../core/error/error_manager.dart';

part 'orders_state.dart';

class OrdersCubit extends MCubit<OrdersInitial> {
  OrdersCubit() : super(OrdersInitial.initial());

  @override
  String get nameCache => 'orders';

  @override
  String get filter => state.filter;

  //region getData

  void getDataFromCache() => getFromCache(
        fromJson: Order.fromJson,
        state: state,
        onSuccess: (data) {
          emit(state.copyWith(result: data));
        },
      );

  Future<void> getData({bool newData = false}) async {
    await getDataAbstract(
      fromJson: Order.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<List<Order>?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: PostUrl.orders,
      body: state.filterRequest?.toJson() ?? {},
    );

    if (response.statusCode.success) {
      return Pair(Orders.fromJson(response.jsonBody).data, null);
    } else {
      return response.getPairError;
    }
  }

  //endregion

  //region CRUD
  Future<void> create() async {
    emit(state.copyWith(statuses: CubitStatuses.loading, cubitCrud: CubitCrud.create));

    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.createOrder,
      body: state.cRequest.toJson(),
    );

    await getData(newData: true);
  }

  Future<void> payOrder() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.getPaymentUrl,
      path: state.id.toString(),
    );

    if (response.statusCode.success) {
      final m = PayOrderResponse.fromJson(response.jsonBody);
      emit(state.copyWith(payOrder: m, statuses: CubitStatuses.done));
    } else {
      emit(state.copyWith(error: ErrorManager.getApiError(response), statuses: CubitStatuses.error));
      showErrorFromApi(state);
    }
  }

  Future<void> update() async {
    emit(state.copyWith(statuses: CubitStatuses.loading, cubitCrud: CubitCrud.update));

    final response = await APIService().callApi(
      type: ApiType.put,
      url: PutUrl.updateOrder,
      // query: {'id': state.cRequest.id},
      body: state.cRequest.toJson(),
    );
    await _updateState(response);
  }

  Future<void> delete({required String id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, cubitCrud: CubitCrud.delete, id: id));

    final response = await APIService().callApi(
      type: ApiType.delete,
      url: DeleteUrl.deleteOrder,
      query: {'id': state.id.toString()},
    );

    await _updateState(response, isDelete: true);
  }

  Future<void> deleteNow({required String id}) async {
    final index = state.result.indexWhere((element) => element.id.toString() == id);
    final item = state.result.removeAt(index);

    emit(state.copyWith(cubitCrud: CubitCrud.delete, result: state.result, id: id));

    final response = await APIService().callApi(
      type: ApiType.delete,
      url: DeleteUrl.deleteOrder,
      query: {'id': state.id.toString()},
    );

    if (response.statusCode.success) {
      await deleteOrderFromCache(item.id.toString());
    } else {
      showErrorFromApi(state);
      state.result.insert(index, item);
      emit(state.copyWith(statuses: CubitStatuses.error, result: state.result));
    }
  }

  Future<void> _updateState(Response response, {bool isDelete = false}) async {
    if (response.statusCode.success) {
      final item = Order.fromJson(response.jsonBody);
      isDelete ? await deleteOrderFromCache(state.id.toString()) : await addOrUpdateOrderToCache(item);
      emit(state.copyWith(statuses: CubitStatuses.done));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.error, error: response.getPairError.second));
      showErrorFromApi(state);
    }
  }

  //endregion

  Future<void> addOrUpdateOrderToCache(Order item) async {
    final listJson = await addOrUpdateDate([item]);
    if (listJson == null) return;
    final list = listJson.map((e) => Order.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }

  Future<void> deleteOrderFromCache(String id) async {
    final listJson = await deleteDate([id]);
    if (listJson == null) return;
    final list = listJson.map((e) => Order.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }
}
