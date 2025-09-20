import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../core/app/app_widget.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/checker_helper.dart';
import '../../../../generated/assets.dart';
import '../../../../router/app_router.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        if (await checkForceUpdate()) {
          showUpdateDialog(
            ctx!,
            child: const UpdateDialog(),
          );
          return;
        }

        switch (getStartPage) {
          case StartPage.login:
            Navigator.pushReplacementNamed(ctx!, RouteName.login);
            break;
          case StartPage.home:
            Navigator.pushReplacementNamed(ctx!, RouteName.home);
            break;
          case StartPage.signupOtp:
            Navigator.pushReplacementNamed(ctx!, RouteName.confirmCode);
          case StartPage.passwordOtp:
            Navigator.pushReplacementNamed(ctx!, RouteName.resetPasswordPage);
            break;
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 1.0.sw,
        height: 1.0.sh,
        child: const Center(
          child: ImageMultiType(url: Assets.imagesLogo),
        ),
      ),
    );
  }
}
