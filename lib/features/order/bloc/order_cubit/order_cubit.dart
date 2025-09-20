import 'package:m_cubit/abstraction.dart';
import 'package:victoria/core/api_manager/api_service.dart';
import 'package:victoria/core/api_manager/api_url.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/strings/enum_manager.dart';
import 'package:victoria/core/util/pair_class.dart';
import 'package:victoria/features/order/data/response/order_response.dart';

part 'order_state.dart';

class OrderCubit extends MCubit<OrderInitial> {
  OrderCubit() : super(OrderInitial.initial());

  @override
  String get nameCache => 'order';

  @override
  String get filter => state.filter;

  Future<void> getData({bool newData = false, String? orderId}) async {
    emit(state.copyWith(id: orderId));

    await getDataAbstract(
      fromJson: Order.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<Order?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.order,
      path: state.id.toString(),
    );

    if (response.statusCode.success) {
      return Pair(Order.fromJson(response.jsonBodyData), null);
    } else {
      return response.getPairError;
    }
  }

  void setOrder(dynamic order) {
    if (order is! Order) return;

    emit(state.copyWith(result: order));
  }
}
