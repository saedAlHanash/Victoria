part of 'order_cubit.dart';

class OrderInitial extends AbstractState<Order> {
  const OrderInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
    super.id,
  });

  factory OrderInitial.initial() {
    return OrderInitial(
      result: Order.fromJson({}),
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
        if (filterRequest != null) filterRequest!,
      ];
      
  OrderInitial copyWith({
    CubitStatuses? statuses,
    Order? result,
    String? error,
    dynamic id,
    String? request,
  }) {
    return OrderInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
      request: request ?? this.request,
    );
  }
}

   