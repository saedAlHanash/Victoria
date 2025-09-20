import 'package:bloc/bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:victoria/core/api_manager/api_service.dart';
import 'package:victoria/core/api_manager/api_url.dart';
import 'package:victoria/core/extensions/extensions.dart';

import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/coupon_response.dart';

part 'coupon_state.dart';

class CouponCubit extends Cubit<CouponInitial> {
  CouponCubit() : super(CouponInitial.initial());

  Future<void> applyCoupon() async {
    if (state.coupon.isEmpty) return;

    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _checkCouponApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      // showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  void setCoupon(String coupon) {
    emit(state.copyWith(coupon: coupon));
  }

  Future<Pair<CouponData?, String?>> _checkCouponApi() async {
    final response = await APIService().callApi(
      type: ApiType.put,
      url: GetUrl.coupon,
      body: {
        'code': state.coupon,
      },
    );
    if (response.statusCode == 200) {
      return Pair(CouponResponse.fromJson(response.jsonBodyPure).data, null);
    } else {
      return response.getPairError;
    }
  }
}
