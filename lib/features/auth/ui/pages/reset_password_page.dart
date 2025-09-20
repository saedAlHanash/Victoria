import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:victoria/core/widgets/my_button.dart';
import 'package:victoria/core/widgets/my_text_form_widget.dart';
import 'package:victoria/features/auth/ui/widget/remember_account.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/reset_password_cubit/reset_password_cubit.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late final ResetPasswordCubit resetPassCubit;
  late final ResetPasswordInitial resetPassState;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    resetPassCubit = context.read<ResetPasswordCubit>();
    resetPassState = context.read<ResetPasswordCubit>().state;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordInitial>(
      listenWhen: (p, c) => c.statuses == CubitStatuses.done,
      listener: (context, state) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteName.donePage,
          (route) => false,
        );
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: MyStyle.authPagesPadding,
                children: [
                  Column(
                    children: [
                      30.0.verticalSpace,
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            MyTextFormOutLineWidget(
                              label: S.of(context).confirmCode,
                              initialValue: resetPassCubit.state.request.code,
                              onChanged: (val) => resetPassCubit.setCode = val,
                            ),
                            MyTextFormOutLineWidget(
                              obscureText: true,
                              validator: (p0) => resetPassCubit.validatePassword,
                              label: S.of(context).password,
                              initialValue: resetPassCubit.state.request.password,
                              keyBordType: TextInputType.emailAddress,
                              onChanged: (val) => resetPassCubit.setPassword = val,
                            ),
                            20.0.verticalSpace,
                            MyTextFormOutLineWidget(
                              obscureText: true,
                              validator: (p0) => resetPassCubit.validateConfirmPassword,
                              label: S.of(context).confirmNewPassword,
                              initialValue: resetPassCubit.state.request.passwordConfirmation,
                              onChanged: (val) => resetPassCubit.setConfirmPassword = val,
                            ),
                          ],
                        ),
                      ),
                      30.0.verticalSpace,
                      BlocBuilder<ResetPasswordCubit, ResetPasswordInitial>(
                        builder: (_, state) {
                          if (state.loading) {
                            return MyStyle.loadingWidget();
                          }
                          return MyButton(
                            text: S.of(context).changePassword,
                            onTap: () {
                              if (!_formKey.currentState!.validate()) return;
                              resetPassCubit.resetPassword();
                            },
                          );
                        },
                      ),
                      20.0.verticalSpace,
                      RememberPassword(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
