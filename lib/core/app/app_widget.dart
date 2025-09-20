import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/core/api_manager/api_service.dart';
import 'package:victoria/core/strings/app_color_manager.dart';
import 'package:victoria/core/strings/enum_manager.dart';
import 'package:victoria/features/address/bloc/addresses_cubit/addresses_cubit.dart';
import 'package:victoria/features/auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import 'package:victoria/features/favorite/bloc/favorites_cubit/favorites_cubit.dart';
import 'package:victoria/features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';

import '../../features/address/bloc/my_location_cubit/my_location_cubit.dart';
import '../../features/ads/bloc/adss_cubit/adss_cubit.dart';
import '../../features/ads/bloc/banners_cubit/banners_cubit.dart';
import '../../features/cart/bloc/cart_cubit/cart_cubit.dart';

import '../../features/cart/bloc/coupon_cubit/coupon_cubit.dart';
import '../../features/category/bloc/categories_cubit/categories_cubit.dart';

import '../../features/governorate/bloc/governorate_cubit/governorate_cubit.dart';
import '../../features/governorate/bloc/governorates_cubit/governorates_cubit.dart';
import '../../features/notification/bloc/all_notification_cubit/all_notification_cubit.dart';
import '../../features/order/bloc/orders_cubit/orders_cubit.dart';
import '../../features/profile/bloc/get_me_cubit/get_me_cubit.dart';
import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../../router/app_router.dart';
import '../app_theme.dart';
import '../injection/injection_container.dart';
import '../util/shared_preferences.dart';
import 'bloc/loading_cubit.dart';

GlobalKey<NavigatorState> _c = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static Future<void> setLocale(BuildContext context, String langCode) async {
    await AppSharedPreference.cashLocal(langCode);
    if (context.mounted) {
      final state = context.findAncestorStateOfType<_MyAppState>();
      await state?.setLocale(Locale.fromSubtags(languageCode: AppSharedPreference.getLocal));
    }
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    S.load(Locale(AppSharedPreference.getLocal));

    setImageMultiTypeErrorImage(
      const Opacity(
        opacity: 0.3,
        child: ImageMultiType(
          url: Assets.imagesLogo,
          height: 30.0,
          width: 30.0,
        ),
      ),
    );
    super.initState();
  }

  Future<void> setLocale(Locale locale) async {
    AppSharedPreference.cashLocal(locale.languageCode);
    await S.load(locale);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: MediaQuery.of(context).size,
      // designSize: const Size(375, 812),
      // designSize: const Size(14440, 972),
      minTextAdapt: true,
      // splitScreenMode: true,
      builder: (context, child) {
        DrawableText.initial(
          initialHeightText: 1.3.sp,
          initialSize: 14.0.sp,
          selectable: false,
          initialFont: FontManager.semeBold.name,
          initialColor: AppColorManager.black,
        );

        return MaterialApp(
          navigatorKey: _c,
          locale: Locale.fromSubtags(languageCode: AppSharedPreference.getLocal),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          builder: (_, child) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => sl<MyLocationCubit>()),
                BlocProvider(create: (_) => sl<LoadingCubit>()),
                BlocProvider(create: (_) => sl<DeleteAccountCubit>()),
                BlocProvider(create: (_) => sl<UpdateProfileCubit>()),
                BlocProvider(create: (_) => sl<GetMeCubit>()..getData()),
                BlocProvider(create: (_) => sl<GovernorateCubit>()..getData()),
                BlocProvider(create: (_) => sl<GovernoratesCubit>()..getData()),
                BlocProvider(create: (_) => sl<AdssCubit>()..getData()),
                BlocProvider(create: (_) => sl<CategoriesCubit>()..getData()),
                BlocProvider(create: (_) => sl<CouponCubit>()),
                BlocProvider(create: (_) => sl<CartCubit>()..getDataFromCache()),
                BlocProvider(create: (_) => sl<NotificationCubit>()..getData()),
                BlocProvider(create: (_) => sl<AddressesCubit>()..getData()),
                BlocProvider(create: (_) => sl<OrdersCubit>()),
                BlocProvider(create: (_) => sl<FavoritesCubit>()..getData()),
              ],
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(.85)),
                child: SafeArea(
                  bottom: true,
                  top: false,
                  left: false,
                  right: false,
                  child: GestureDetector(
                    onTap: () {
                      final currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                    child: child!,
                  ),
                ),
              ),
            );
          },
          scrollBehavior: MyCustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          onGenerateRoute: AppRoutes.routes,
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

BuildContext? get ctx => _c.currentContext;
