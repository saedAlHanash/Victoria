import 'dart:async';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:victoria/core/app/app_provider.dart';
import 'package:victoria/core/strings/enum_manager.dart';
import 'package:victoria/features/auth/data/request/resend_request.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/resend_code_cubit/resend_code_cubit.dart';

class ResendBtn extends StatefulWidget {
  const ResendBtn({super.key});

  @override
  State<ResendBtn> createState() => _ResendBtnState();
}

class _ResendBtnState extends State<ResendBtn> {
  Timer? timer;

  var countRemaining = 0;

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (countRemaining <= 0) {
          setState(() => timer.cancel());
          return;
        }
        setState(() => countRemaining--);
      },
    );
  }

  @override
  void initState() {
    countRemaining = AppProvider.getRemaining;
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<ResendCodeCubit, ResendCodeInitial>(
        listenWhen: (p, c) => c.done,
        listener: (context, state) {
          countRemaining = AppProvider.getRemaining;
          if (countRemaining <= 0) {
            setState(() {});
            return;
          }
          timer?.cancel();
          startTimer();
        },
        builder: (context, state) {
          if (state.loading) {
            return MyStyle.loadingWidget();
          }
          return countRemaining > 0
              ? DrawableText(
                  matchParent: true,
                  textAlign: TextAlign.center,
                  text: countRemaining.toString(),
                  size: 24.0.sp,
                )
              : DrawableText(
                  text: S.of(context).didntReceiveTheCode,
                  drawablePadding: 10.0.w,
                  drawableEnd: InkWell(
                    onTap: () {
                      if (AppSharedPreference.getEmail.isEmpty) {
                        Navigator.pushReplacementNamed(context, RouteName.login);
                        return;
                      }
                      context.read<ResendCodeCubit>().resendCode(request: ResendRequest());
                    },
                    child: DrawableText(
                      text: S.of(context).resend,
                      fontFamily: FontManager.bold.name,
                      color: AppColorManager.mainColor,
                    ),
                  ),
                );
        },
      ),
    );
  }
}
