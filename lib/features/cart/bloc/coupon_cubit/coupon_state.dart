part of 'coupon_cubit.dart';

class CouponInitial extends AbstractState<CouponData> {
  final String coupon;

  const CouponInitial({
    required super.result,
    super.statuses,
    super.error,
    required this.coupon,
  });

  factory CouponInitial.initial() {
    return CouponInitial(
      result: CouponData.fromJson({}),
      coupon: '',
    );
  }

  num calculateDiscount(num subtotal) {
    switch (result.type) {
      case CouponType.fixed:
        return (num.tryParse(result.discount) ?? 0);
      case CouponType.percentage:
        final discountPercent = num.tryParse(result.discount) ?? 0;
        return (subtotal * discountPercent / 100);
    }
  }

  num calculateTotal(num subtotal) {
    switch (result.type) {
      case CouponType.fixed:
        return subtotal - (num.tryParse(result.discount) ?? 0);
      case CouponType.percentage:
        final discountPercent = num.tryParse(result.discount) ?? 0;
        return subtotal - (subtotal * discountPercent / 100);
    }
  }

  @override
  List<Object> get props => [statuses, result, error, coupon];

  CouponInitial copyWith({
    CubitStatuses? statuses,
    CouponData? result,
    String? error,
    String? coupon,
  }) {
    return CouponInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      coupon: coupon ?? this.coupon,
    );
  }
}
