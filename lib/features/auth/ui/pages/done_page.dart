import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/core/strings/enum_manager.dart';
import 'package:victoria/core/widgets/app_bar/app_bar_widget.dart';
import 'package:victoria/core/widgets/my_button.dart';
import 'package:victoria/features/auth/ui/widget/auth_card_image.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';

class DonePage extends StatelessWidget {
  const DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        zeroHeight: true,
      ),
      body: Column(
        children: [
          AuthCardImage(
            titleText: S.of(context).done,
            description: S.of(context).yourAccountHasBeenCreatedSuccessfully,
          ),
          ImageMultiType(
            url: Assets.iconsDone,
            height: 348.0.h,
            width: 1.0.sw,
          ),
          10.0.verticalSpace,
          DrawableText(
            text: S.of(context).isSuccess,
            size: 24.0.sp,
            fontFamily: FontManager.bold.name,
            textAlign: TextAlign.center,
          ),
          Spacer(),
          MyButton(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, RouteName.splash, (route) => false);
            },
            text: S.of(context).done,
          ),
          20.0.verticalSpace,
        ],
      ),
    );
  }
}
