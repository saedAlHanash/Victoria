import 'package:victoria/features/address/bloc/address_cubit/address_cubit.dart';
import 'package:victoria/features/address/bloc/addresses_cubit/addresses_cubit.dart';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:victoria/features/category/bloc/categories_cubit/categories_cubit.dart';
import 'package:victoria/features/category/bloc/category_cubit/category_cubit.dart';
import 'package:victoria/features/favorite/bloc/favorite_cubit/favorite_cubit.dart';
import 'package:victoria/features/favorite/bloc/favorites_cubit/favorites_cubit.dart';
import 'package:victoria/features/order/bloc/order_cubit/order_cubit.dart';
import 'package:victoria/features/order/bloc/orders_cubit/orders_cubit.dart';
import 'package:victoria/features/product/bloc/product_cubit/product_cubit.dart';
import 'package:victoria/features/product/bloc/products_cubit/products_cubit.dart';

import '../../features/address/bloc/my_location_cubit/my_location_cubit.dart';
import '../../features/ads/bloc/ads_cubit/ads_cubit.dart';
import '../../features/ads/bloc/adss_cubit/adss_cubit.dart';
import '../../features/ads/bloc/banners_cubit/banners_cubit.dart';
import '../../features/auth/bloc/change_password_cubit/change_password_cubit.dart';
import '../../features/auth/bloc/confirm_code_cubit/confirm_code_cubit.dart';
import '../../features/auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import '../../features/auth/bloc/forget_password_cubit/forget_password_cubit.dart';
import '../../features/auth/bloc/login_cubit/login_cubit.dart';
import '../../features/auth/bloc/otp_password_cubit/otp_password_cubit.dart';
import '../../features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import '../../features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import '../../features/auth/bloc/signup_cubit/signup_cubit.dart';
import '../../features/cart/bloc/cart_cubit/cart_cubit.dart';

import '../../features/cart/bloc/coupon_cubit/coupon_cubit.dart';

import '../../features/governorate/bloc/governorate_cubit/governorate_cubit.dart';
import '../../features/governorate/bloc/governorates_cubit/governorates_cubit.dart';
import '../../features/home/bloc/home_cubit/home_cubit.dart';
import '../../features/notification/bloc/all_notification_cubit/all_notification_cubit.dart';
import '../../features/notification/bloc/notification_count_cubit/notification_count_cubit.dart';
import '../../features/profile/bloc/delete_my_account_cubit/delete_my_account_cubit.dart';
import '../../features/profile/bloc/get_me_cubit/get_me_cubit.dart';
import '../../features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';
import '../app/bloc/loading_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //region address
  sl.registerFactory(() => AddressCubit());
  sl.registerFactory(() => AddressesCubit());
  //endregion

  //region Cart

  sl.registerFactory(() => CartCubit());
  sl.registerFactory(() => CouponCubit());

  //endregion

  //region Governorate

  sl.registerFactory(() => GovernorateCubit());
  sl.registerFactory(() => GovernoratesCubit());

  //endregion

  //region order
  sl.registerFactory(() => OrderCubit());
  sl.registerFactory(() => OrdersCubit());
  //endregion

  //region favorite
  sl.registerFactory(() => FavoriteCubit());
  sl.registerFactory(() => FavoritesCubit());

  //endregion

  //region product
  sl.registerFactory(() => ProductCubit());
  sl.registerFactory(() => ProductsCubit());
  //endregion

  //region category
  sl.registerFactory(() => CategoryCubit());
  sl.registerFactory(() => CategoriesCubit());
  //endregion

  //region ads
  sl.registerFactory(() => AdsCubit());
  sl.registerFactory(() => AdssCubit());
  //endregion

  //region Core

  sl.registerLazySingleton(() => LoadingCubit());
  sl.registerCachedFactory(() => MyLocationCubit());
  sl.registerLazySingleton(() => GlobalKey<NavigatorState>());

  sl.registerLazySingleton(() => HomeCubit());

  //endregion

  //region auth

  sl.registerFactory(() => LoginCubit());
  sl.registerFactory(() => ForgetPasswordCubit());
  sl.registerFactory(() => ResetPasswordCubit());
  sl.registerFactory(() => ConfirmCodeCubit());
  sl.registerFactory(() => ResendCodeCubit());
  sl.registerFactory(() => OtpPasswordCubit());
  sl.registerFactory(() => SignupCubit());
  sl.registerFactory(() => ChangePasswordCubit());
  sl.registerFactory(() => DeleteAccountCubit());

  //endregion

  // region profile
  sl.registerFactory(() => DeleteMyAccountCubit());
  sl.registerFactory(() => GetMeCubit());
  sl.registerFactory(() => UpdateProfileCubit());

  //endregion

  //region Notification
  sl.registerFactory(() => NotificationCubit());
  sl.registerFactory(() => NotificationCountCubit());
  //endregion

  //region manufacturers

  //endregion

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
