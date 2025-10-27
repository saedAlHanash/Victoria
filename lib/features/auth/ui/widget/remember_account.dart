import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';

class RememberPassword extends StatelessWidget {
  const RememberPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DrawableText(
        text: S.of(context).iRememberedMyPassword,
        color: AppColorManager.grey,
        drawablePadding: 7.0.w,
        drawableEnd: InkWell(
          onTap: () {
            AppSharedPreference.removeEmail().then((value) {
              Navigator.pushNamed(context, RouteName.login);
            });
          },
          child: DrawableText(
            color: AppColorManager.mainColor,
            fontFamily: FontManager.bold.name,
            text: '${S.of(context).login}.',
          ),
        ),
      ),
    );
  }
}

class RememberAccount extends StatelessWidget {
  const RememberAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DrawableText(
        text: S.of(context).iWantToChangeAccount,
        color: AppColorManager.grey,
        drawablePadding: 7.0.w,
        drawableEnd: InkWell(
          onTap: () async {
            await AppSharedPreference.removeEmail();
            await AppSharedPreference.cashStartPage(StartPage.login);
            if (context.mounted) {
              Navigator.pushNamed(context, RouteName.login);
            }
          },
          child: DrawableText(
            color: AppColorManager.mainColor,
            fontFamily: FontManager.bold.name,
            text: '${S.of(context).changeAccount}.',
          ),
        ),
      ),
    );
  }
}
