import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:victoria/features/category/data/response/category_response.dart';
import 'package:victoria/features/category/ui/pages/categorys_page.dart';
import 'package:victoria/features/order/bloc/orders_cubit/orders_cubit.dart';
import 'package:victoria/features/order/ui/pages/orders_page.dart';

import '../core/injection/injection_container.dart';
import '../core/util/pair_class.dart';
import '../features/address/bloc/addresses_cubit/addresses_cubit.dart';
import '../features/address/ui/pages/addresss_page.dart';
import '../features/address/ui/pages/map_page.dart';
import '../features/auth/bloc/change_password_cubit/change_password_cubit.dart';
import '../features/auth/bloc/confirm_code_cubit/confirm_code_cubit.dart';
import '../features/auth/bloc/forget_password_cubit/forget_password_cubit.dart';
import '../features/auth/bloc/login_cubit/login_cubit.dart';
import '../features/auth/bloc/otp_password_cubit/otp_password_cubit.dart';
import '../features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import '../features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import '../features/auth/bloc/signup_cubit/signup_cubit.dart';
import '../features/auth/ui/pages/change_password_page.dart';
import '../features/auth/ui/pages/confirm_code_page.dart';
import '../features/auth/ui/pages/done_page.dart';
import '../features/auth/ui/pages/forget_passowrd_page.dart';
import '../features/auth/ui/pages/login_page.dart';
import '../features/auth/ui/pages/otp_password_page.dart';
import '../features/auth/ui/pages/reset_password_page.dart';
import '../features/auth/ui/pages/signup_page.dart';
import '../features/auth/ui/pages/splash_screen_page.dart';

import '../features/category/bloc/categories_cubit/categories_cubit.dart';
import '../features/home/ui/pages/home_page.dart';
import '../features/order/bloc/order_cubit/order_cubit.dart';
import '../features/order/ui/pages/order_page.dart';
import '../features/product/bloc/product_cubit/product_cubit.dart';
import '../features/product/bloc/products_cubit/products_cubit.dart';
import '../features/product/data/request/filter_product_request.dart';
import '../features/product/ui/pages/product_page.dart';
import '../features/product/ui/pages/products_page.dart';
import '../features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';
import '../features/profile/ui/pages/profile_page.dart';

class AppRoutes {
  static Route<dynamic> routes(RouteSettings settings) {
    var screenName = settings.name ?? '';

    switch (screenName) {
      //region auth
      case RouteName.splash:
        //region
        return MaterialPageRoute(builder: (_) => const SplashScreenPage());
      //endregion
      case RouteName.signup:
        //region
        {
          return MaterialPageRoute(
            builder: (_) {
              final providers = [
                BlocProvider(create: (_) => sl<SignupCubit>()),
              ];
              return MultiBlocProvider(
                providers: providers,
                child: const SignupPage(),
              );
            },
          );
        }
      //endregion
      case RouteName.login:
        //region
        {
          final providers = [
            BlocProvider(create: (_) => sl<LoginCubit>()),
          ];
          return MaterialPageRoute(
            builder: (_) {
              return MultiBlocProvider(
                providers: providers,
                child: const LoginPage(),
              );
            },
          );
        }
      //endregion
      case RouteName.forgetPassword:
        //region
        {
          final providers = [
            BlocProvider(create: (_) => sl<ForgetPasswordCubit>()),
          ];
          final arg = settings.arguments;
          return MaterialPageRoute(
            builder: (_) {
              return MultiBlocProvider(
                providers: providers,
                child: ForgetPasswordPage(phone: arg is String ? arg : null),
              );
            },
          );
        }
      //endregion
      case RouteName.resetPasswordPage:
        //region
        {
          final providers = [
            BlocProvider(create: (_) => sl<ResetPasswordCubit>()),
          ];
          return MaterialPageRoute(
            builder: (_) {
              return MultiBlocProvider(
                providers: providers,
                child: const ResetPasswordPage(),
              );
            },
          );
        }
      //endregion
      case RouteName.confirmCode:
        //region
        {
          final providers = [
            BlocProvider(create: (_) => sl<ConfirmCodeCubit>()),
            BlocProvider(create: (_) => sl<ResendCodeCubit>()),
          ];
          return MaterialPageRoute(
            builder: (_) {
              return MultiBlocProvider(
                providers: providers,
                child: const ConfirmCodePage(),
              );
            },
          );
        }
      //endregion
      case RouteName.otpPassword:
        //region
        {
          final providers = [
            BlocProvider(create: (_) => sl<OtpPasswordCubit>()),
            BlocProvider(create: (_) => sl<ResendCodeCubit>()),
          ];
          return MaterialPageRoute(
            builder: (_) {
              return MultiBlocProvider(
                providers: providers,
                child: const OtpPasswordPage(),
              );
            },
          );
        }
      //endregion
      case RouteName.donePage:
        //region
        {
          return MaterialPageRoute(
            builder: (_) {
              return const DonePage();
            },
          );
        }
      //endregion
      case RouteName.changePasswordPage:
        //region
        {
          final providers = [
            BlocProvider(create: (context) => sl<ChangePasswordCubit>()),
          ];
          return MaterialPageRoute(builder: (context) {
            return MultiBlocProvider(
              providers: providers,
              child: const ChangePasswordPage(),
            );
          });
        }
      //endregion
      //endregion auth

      //region home
      case RouteName.home:
        //region
        {
          return MaterialPageRoute(
            builder: (_) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => sl<ProductsCubit>()..getData(),
                  ),
                ],
                child: Homepage(),
              );
            },
          );
        }
      //endregion
      //endregion home

      //region product

      case RouteName.product:
        //region
        final providers = [
          BlocProvider(
            create: (_) => sl<ProductCubit>()..getData(productId: (settings.arguments ?? 0).toString()),
          ),
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child: const ProductPage(),
            );
          },
        );

      //endregion

      case RouteName.products:
        final list = settings.arguments as List;
        var provider = list[0] is ProductsCubit ? list[0] as ProductsCubit : null;
        var filter = list[0] is FilterProductRequest ? list[0] as FilterProductRequest : null;

        final providers = [
          if (provider == null) BlocProvider(create: (_) => sl<CategoriesCubit>()..getData(category: filter?.category)),
          if (provider != null) BlocProvider.value(value: provider),
          if (provider == null) BlocProvider(create: (_) => sl<ProductsCubit>()),
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child: ProductsPage(
                title: (settings.arguments as List)[1] as String,
                withSearch: provider == null,
              ),
            );
          },
        );
      //endregion

      //region settings
      case RouteName.profile:
        {
          return MaterialPageRoute(
            builder: (_) {
              final providers = [
                BlocProvider(create: (_) => sl<UpdateProfileCubit>()),
              ];
              return MultiBlocProvider(
                providers: providers,
                child: const ProfilePage(),
              );
            },
          );
        }
      //endregion

      //region order

      case RouteName.orders:
        {
          return MaterialPageRoute(
            builder: (_) {
              final providers = [
                BlocProvider(create: (_) => sl<OrdersCubit>()..getData()),
              ];
              return MultiBlocProvider(
                providers: providers,
                child: const OrdersPage(),
              );
            },
          );
        }

      case RouteName.order:
        {
          return MaterialPageRoute(
            builder: (_) {
              final providers = [
                BlocProvider(create: (_) => sl<OrderCubit>()..getData(orderId: settings.arguments.toString())),
              ];
              return MultiBlocProvider(
                providers: providers,
                child: const OrderPage(),
              );
            },
          );
        }

      //endregion

      //region address
      case RouteName.map:
        {
          return MaterialPageRoute(
            builder: (_) {
              return MapPage(
                initial: (settings.arguments ?? initialLocation) as LatLng,
              );
            },
          );
        }

      case RouteName.address:
        {
          return MaterialPageRoute(
            builder: (_) {
              return AddressesPage();
            },
          );
        }
      //endregion

      //region categories
      case RouteName.categories:
        {
          return MaterialPageRoute(
            builder: (_) {
              return CategoriesPage();
            },
          );
        }

      //endregion
    }

    return MaterialPageRoute(builder: (_) => const SplashScreenPage());
  }
}

class RouteName {
  static const splash = '/';
  static const products = '/products';
  static const product = '/product';
  static const welcomeScreen = '/welcomeScreen';
  static const home = '/home';
  static const forgetPassword = '/forgetPassword';
  static const resetPasswordPage = '/resetPasswordPage';
  static const login = '/login';
  static const signup = '/signup';
  static const confirmCode = '/confirmCode';
  static const otpPassword = '/otpPassword';
  static const donePage = '/donePage';
  static const teacher = '/teacher';
  static const profile = '/profile';
  static const changePasswordPage = '/changePasswordPage';
  static const notifications = '/notifications';
  static const pdf = '/pdf';
  static const lesson = '/lesson';
  static const pay = '/pay';
  static const chapters = '/chapters';
  static const lessons = '/lessons';
  static const player = '/player';
  static const search = '/search';
  static const teacherSubscriptions = '/teacherSubscriptions';
  static const map = '/map';
  static const address = '/address';

  // static const teachers = '/teachers;
  static const groups = '/groups';
  static const rooms = '/rooms';

  static const sections = '/sections';
  static const grades = '/grades';

  static const startExam = '/startExam';
  static const examScore = '/examScore';
  static const orders = '/orders';

  static const order = '/order';
  static const categories = '/categories';
}
