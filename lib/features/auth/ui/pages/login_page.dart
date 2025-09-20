import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:victoria/core/api_manager/api_service.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/strings/app_color_manager.dart';
import 'package:victoria/core/strings/enum_manager.dart';
import 'package:victoria/core/widgets/app_bar/app_bar_widget.dart';
import 'package:victoria/core/widgets/my_button.dart';
import 'package:victoria/core/widgets/my_text_form_widget.dart';
import 'package:victoria/features/auth/ui/widget/auth_card_image.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../notification/bloc/all_notification_cubit/all_notification_cubit.dart';
import '../../../profile/bloc/get_me_cubit/get_me_cubit.dart';
import '../../bloc/login_cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginCubit get loginCubit => context.read<LoginCubit>();

  final _formKey = GlobalKey<FormState>();

  void updateData() {
    context.read<GetMeCubit>().getData(newData: true);
    context.read<NotificationCubit>().getData(newData: true);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            updateData();
            Navigator.pushNamedAndRemoveUntil(context, RouteName.home, (route) => false);
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget(
          zeroHeight: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AuthCardImage(
                  titleText: S.of(context).logInToYourAccount,
                  description: S.of(context).enterYourPhoneAndPasswordToLogIn,
                ),
                Container(
                  padding: const EdgeInsets.all(20.0).r,
                  margin: const EdgeInsets.all(20.0).r,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0).r,
                    boxShadow: [
                      BoxShadow(
                        color: AppColorManager.black.withValues(alpha: 0.06),
                        blurRadius: 24,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      AutofillGroup(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
                          child: Column(
                            children: [
                              MyTextFormOutLineWidget(
                                autofillHints: const [
                                  AutofillHints.username,
                                  AutofillHints.email,
                                ],
                                validator: (p0) => p0.validateEmpty,
                                hint: S.of(context).email,
                                initialValue: loginCubit.state.request.email,
                                keyBordType: TextInputType.emailAddress,
                                onChanged: (val) => loginCubit.setPhone = val,
                              ),
                              MyTextFormOutLineWidget(
                                autofillHints: const [AutofillHints.password],
                                validator: (p0) => loginCubit.validatePassword,
                                // labelText: S.of(context).password,
                                hint: S.of(context).password,
                                obscureText: true,
                                initialValue: loginCubit.state.request.password,
                                onChanged: (val) => loginCubit.setPassword = val,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                RouteName.forgetPassword,
                                arguments: loginCubit.state.request.email,
                              );
                            },
                            child: DrawableText(
                              text: S.of(context).forgetPassword,
                              color: AppColorManager.mainColor,
                              fontFamily: FontManager.bold.name,
                            ),
                          ),
                          Spacer(),
                          DrawableText(
                            text: 'تذكرني',
                            color: Colors.grey,
                            drawableEnd: Checkbox(
                              value: true,
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                      10.0.verticalSpace,
                      BlocBuilder<LoginCubit, LoginInitial>(
                        builder: (_, state) {
                          return MyButton(
                            text: S.of(context).login,
                            loading: state.loading,
                            onTap: () async {
                              if (!_formKey.currentState!.validate()) return;
                              TextInput.finishAutofillContext();
                              loginCubit.login();
                            },
                          );
                        },
                      ),
                      18.0.verticalSpace,
                      DrawableText(
                        text: S.of(context).doNotHaveAnAccount,
                        drawableEnd: TextButton(
                          onPressed: () => Navigator.pushNamed(context, RouteName.signup),
                          child: DrawableText(
                            fontFamily: FontManager.bold.name,
                            color: AppColorManager.mainColor,
                            text: S.of(context).createNewAccount,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ForgetAndRememberWidget extends StatefulWidget {
  const _ForgetAndRememberWidget();

  @override
  State<_ForgetAndRememberWidget> createState() => _ForgetAndRememberWidgetState();
}

class _ForgetAndRememberWidgetState extends State<_ForgetAndRememberWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DrawableText(
          text: S.of(context).rememberMe,
          drawableEnd: Checkbox(
            value: true,
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }
}
