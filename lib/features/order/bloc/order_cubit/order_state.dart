part of 'order_cubit.dart';

class OrderInitial extends AbstractState<Order> {
  const OrderInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
    super.id,
    required this.payOrder,
  });

  final PayOrderResponse payOrder;

  factory OrderInitial.initial() {
    return OrderInitial(
      result: Order.fromJson({}),
      payOrder: PayOrderResponse.fromJson({}),
      request: '',
    );
  }

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        if (request != null) request,
        if (id != null) id,
        payOrder,
        if (filterRequest != null) filterRequest!,
      ];

  OrderInitial copyWith({
    CubitStatuses? statuses,
    Order? result,
    String? error,
    dynamic id,
    String? request,
    PayOrderResponse? payOrder,
  }) {
    return OrderInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
      payOrder: payOrder ?? this.payOrder,
      request: request ?? this.request,
    );
  }
}
