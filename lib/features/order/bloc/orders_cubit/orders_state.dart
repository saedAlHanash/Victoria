part of 'orders_cubit.dart';

class OrdersInitial extends AbstractState<List<Order>> {
  const OrdersInitial({
    required super.result,
    super.error,
    super.request,
    super.filterRequest,
    super.cubitCrud,
    super.createUpdateRequest,
    super.statuses,
    super.id,
  });

  factory OrdersInitial.initial() {
    return  OrdersInitial(
      result: [],
      createUpdateRequest: CreateOrderRequest.fromJson({}),
    );
  }

  CreateOrderRequest get  cRequest => createUpdateRequest;

  String get mId => id;

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        cubitCrud,
        if (id != null) id,
        if (request != null) request,
        if (filterRequest != null) filterRequest!,
        if (createUpdateRequest != null) createUpdateRequest!,
      ];

  OrdersInitial copyWith({
    CubitStatuses? statuses,
    CubitCrud? cubitCrud,
    List<Order>? result,
    String? error,
    FilterRequest? filterRequest,
    dynamic request,
    dynamic cRequest,
    dynamic id,
  }) {
    return OrdersInitial(
      statuses: statuses ?? this.statuses,
      cubitCrud: cubitCrud ?? this.cubitCrud,
      result: result ?? this.result,
      error: error ?? this.error,
      filterRequest: filterRequest ?? this.filterRequest,
      request: request ?? this.request,
      createUpdateRequest: cRequest ?? this.cRequest,
      id: id ?? this.id,
    );
  }
}

