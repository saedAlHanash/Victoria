import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/core/api_manager/api_url.dart';

import '../../features/auth/data/response/login_response.dart';
import '../../features/profile/data/response/profile_response.dart';
import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../../router/app_router.dart';
import '../strings/enum_manager.dart';
import '../util/checker_helper.dart';
import '../util/shared_preferences.dart';
import '../util/snack_bar_message.dart';
import 'app_widget.dart';

class AppProvider {
  static int get getRemaining => AppSharedPreference.getResendDateTime.difference(DateTime.now()).inSeconds;

  static Future<void> setResendTime(int s) async {
    await AppSharedPreference.setResendDateTime(s);
  }

  static String get supperFilter => '${getMe.id}${AppSharedPreference.getLocal}';

  static bool get isTestMode => baseUrl == test;

  static int _myId = 0;

  static int get myId {
    if (_myId == 0) _myId = getMe.id;
    return _myId;
  }

  static SettingResult _systemParams = SettingResult.fromJson({});

  static SettingResult get systemParams => _systemParams;

  static set setSetting(SettingResult data) => _systemParams = data;

  final fcmToken = AppSharedPreference.getFireToken;

  static Profile get getMe => AppSharedPreference.getUser;

  //
  static bool get isStoreTest {
    if (Platform.isAndroid) return false;

    if (getMe.id == 11) return true;

    return systemParams.isIosTest && appBuildNum > systemParams.mainAppVersionIos;
  }

  // static bool get isStoreTest => false;

  static bool get isLogin => AppSharedPreference.getToken.isNotEmpty;

  static bool get isNotLogin => !isLogin;

  static bool get needLogin {
    if (isNotLogin) {
      if (ctx != null) {
        NoteMessage.showCheckDialog(
          ctx!,
          text: S.of(ctx!).needLogin,
          textButton: S.of(ctx!).login,
          image: Icons.login,
          onConfirm: () {
            Navigator.pushNamed(ctx!, RouteName.login);
          },
        );
      }
      return true;
    }
    return false;
  }

  static Future<void> login({required LoginResponse response}) async {
    await AppSharedPreference.cashToken(response.token);
    await AppSharedPreference.cashUser(response.user);
  }

  static bool? get isSignupCashed {
    if (AppSharedPreference.getStartPage == StartPage.signupOtp) return true;
    if (AppSharedPreference.getStartPage == StartPage.passwordOtp) return false;
    return null;
  }

  static Future<void> logout({bool withDialog = true}) async {
    if (ctx == null) return;
    if (withDialog) {
      NoteMessage.showCheckDialog(
        ctx!,
        text: 'تأكيد تسجيل الخروج',
        textButton: 'تسجيل الخروج',
        image: ImageMultiType(url: Assets.imagesLogo, height: 100.0.r, width: 100.0.r),
        onConfirm: () async {
          await AppSharedPreference.logout();
          await AppSharedPreference.reload();
          _myId = 0;

          Navigator.pushNamedAndRemoveUntil(ctx!, RouteName.login, (route) => false);
        },
      );
    } else {
      await AppSharedPreference.logout();
      await AppSharedPreference.reload();
      _myId = 0;
      Navigator.pushNamedAndRemoveUntil(ctx!, RouteName.login, (route) => false);
    }
  }

  static Future<void> cacheEmail({required String phone, required StartPage type}) async {
    await AppSharedPreference.cashEmail(phone);
    await AppSharedPreference.cashStartPage(type);
  }

  static String get getPhoneCached => AppSharedPreference.getEmail;
}

StartPage get getStartPage {
  if (AppProvider.isLogin) return StartPage.home;

  return AppSharedPreference.getStartPage;
}
