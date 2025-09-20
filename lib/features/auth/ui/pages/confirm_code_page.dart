import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:victoria/core/util/snack_bar_message.dart';
import 'package:victoria/core/widgets/app_bar/app_bar_widget.dart';
import 'package:victoria/core/widgets/my_button.dart';
import 'package:victoria/features/auth/ui/widget/auth_card_image.dart';
import 'package:victoria/features/auth/ui/widget/remember_account.dart';
import 'package:victoria/features/auth/ui/widget/resend_btn.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/verification_code_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/confirm_code_cubit/confirm_code_cubit.dart';
import '../../bloc/resend_code_cubit/resend_code_cubit.dart';

class ConfirmCodePage extends StatefulWidget {
  const ConfirmCodePage({super.key});

  @override
  State<ConfirmCodePage> createState() => _ConfirmCodePageState();
}

class _ConfirmCodePageState extends State<ConfirmCodePage> {
  late final ConfirmCodeCubit confirmCodeCubit;
  late final ResendCodeCubit resendCodeCubit;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    confirmCodeCubit = context.read<ConfirmCodeCubit>();
    resendCodeCubit = context.read<ResendCodeCubit>();
    confirmCodeCubit.setPhone = AppSharedPreference.getEmail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ConfirmCodeCubit, ConfirmCodeInitial>(
          listenWhen: (p, current) => current.statuses == CubitStatuses.done,
          listener: (context, state) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteName.donePage,
              (route) => false,
            );
          },
        ),
        BlocListener<ResendCodeCubit, ResendCodeInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            NoteMessage.showAwesomeDoneDialog(
              context,
              message: state.error.isEmpty ? '${S.of(context).done_resend_code} ${state.result}' : state.error,
            );
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget(zeroHeight: true, color: AppColorManager.mainColorLight),
        body: ListView(
          children: [
            AuthCardImage(
                titleText: S.of(context).verifyTheVerificationCode,
                description: S.of(context).enterTheFollowingInformation),
            Container(
              padding: const EdgeInsets.all(20.0).r,
              margin: const EdgeInsets.all(20.0).r,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColorManager.black.withValues(alpha: 0.06),
                    blurRadius: 24,
                  ),
                ],
                borderRadius: BorderRadius.circular(10.0).r,
              ),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: PinCodeWidget(
                      onChange: (p0) => setState(() => confirmCodeCubit.setCode = p0),
                      validator: (p0) => confirmCodeCubit.validateCode,
                    ),
                  ),
                  40.0.verticalSpace,
                  ResendBtn(),
                  40.0.verticalSpace,
                  BlocBuilder<ConfirmCodeCubit, ConfirmCodeInitial>(
                    builder: (context, state) {
                      if (state.loading) {
                        return MyStyle.loadingWidget();
                      }
                      return MyButton(
                        enable: state.canSend,
                        text: S.of(context).sendCode,
                        onTap: () {
                          if (AppSharedPreference.getEmail.isEmpty) {
                            Navigator.pushReplacementNamed(context, RouteName.login);
                            return;
                          }
                          if (!_formKey.currentState!.validate()) return;
                          confirmCodeCubit.confirmCode();
                        },
                      );
                    },
                  ),
                  20.0.verticalSpace,
                  RememberAccount(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
