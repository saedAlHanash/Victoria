part of 'cart_cubit.dart';

class CartInitial extends AbstractState<List<Product>> {
  const CartInitial({
    required super.result,
    super.error,
    super.request,
    super.filterRequest,
    super.cubitCrud,
    super.createUpdateRequest,
    super.statuses,
    super.id,
    required this.address,
    required this.coupon,
  });

  final Address address;
  final CouponData coupon;
  String get couponCode => request.toString();
  factory CartInitial.initial() {
    return CartInitial(
      result: [],
      address: Address.fromJson({}),
      coupon: CouponData.fromJson({}),
    );
  }

  String get mId => id ?? '';

  num get productsPrice {
    final listPrice = result.map((e) => e.priceAfter * e.count);
    if (listPrice.isEmpty) return 0;
    return listPrice.reduce((value, element) => value + element);
  }

  num get totalPrice {
    return productsPrice + address.governorate.deliveryPrice - coupon.calculateDiscount(productsPrice);
  }

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
        address,
        coupon,
      ];

  CartInitial copyWith({
    CubitStatuses? statuses,
    CubitCrud? cubitCrud,
    List<Product>? result,
    String? error,
    FilterRequest? filterRequest,
    dynamic request,
    dynamic id,
    Address? address,
    CouponData? coupon,
  }) {
    return CartInitial(
      statuses: statuses ?? this.statuses,
      cubitCrud: cubitCrud ?? this.cubitCrud,
      result: result ?? this.result,
      error: error ?? this.error,
      filterRequest: filterRequest ?? this.filterRequest,
      request: request ?? this.request,
      id: id ?? this.id,
      address: address ?? this.address,
      coupon: coupon ?? this.coupon,
    );
  }
}
