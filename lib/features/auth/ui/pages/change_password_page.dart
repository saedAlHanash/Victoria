import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:victoria/core/util/snack_bar_message.dart';
import 'package:victoria/core/widgets/app_bar/app_bar_widget.dart';
import 'package:victoria/core/widgets/my_button.dart';
import 'package:victoria/core/widgets/my_text_form_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/change_password_cubit/change_password_cubit.dart';
import '../../data/request/change_password_request.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final request = ChangePasswordRequest();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordInitial>(
      listenWhen: (p, c) => c.statuses == CubitStatuses.done,
      listener: (context, state) {
        NoteMessage.showDoneDialog(
          context,
          text: 'تم تغيير كلمة المرور بنجاح',
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
      child: Scaffold(
        appBar: const AppBarWidget(
          titleText: 'تغيير كلمة المرور',
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0).r,
          child: Column(
            children: [
              const DrawableText(
                text: 'يرجى إدخال كلمة المرور القديمة والجديدة',
                matchParent: true,
                textAlign: TextAlign.center,
              ),
              100.0.verticalSpace,
              MyTextFormOutLineWidget(
                textDirection: TextDirection.ltr,
                keyBordType: TextInputType.visiblePassword,
                label: 'كلمة المرور القديمة',
                onChanged: (val) => request.oldPass = val,
              ),
              20.0.verticalSpace,
              MyTextFormOutLineWidget(
                textDirection: TextDirection.ltr,
                keyBordType: TextInputType.visiblePassword,
                label: 'كلمة المرور الجديدة',
                onChanged: (val) => request.newPass = val,
              ),
              const Spacer(),
              BlocBuilder<ChangePasswordCubit, ChangePasswordInitial>(
                builder: (_, state) {
                  if (state.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    width: 314.0.w,
                    text: S.of(context).update,
                    onTap: () {
                      context.read<ChangePasswordCubit>().changePassword(request: request);
                    },
                  );
                },
              ),
              40.0.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
