import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/round_image_widget.dart';

import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../../router/app_router.dart';
import '../strings/enum_manager.dart';
import 'my_button.dart';

class NeedLoginWidget extends StatelessWidget {
  const NeedLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundImageWidget(
                url: Assets.iconsLogo,
                height: 200.0.r,
                width: 200.0.r,
              ),
              20.0.verticalSpace,
              DrawableText(
                text: 'تحتاج لتسجيل الدخول للمتابعة',
                size: 20.0.sp,
                textAlign: TextAlign.center,
                fontFamily: FontManager.bold.name,
              ),
              20.0.verticalSpace,
              MyButton(
                text: S.of(context).login,
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, RouteName.login, (route) => false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
