import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:victoria/core/app/app_provider.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/util/shared_preferences.dart';
import 'package:victoria/core/widgets/app_bar/app_bar_widget.dart';
import 'package:victoria/core/widgets/need_login_widget.dart';
import 'package:victoria/core/widgets/refresh_widget/refresh_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/all_notification_cubit/all_notification_cubit.dart';
import '../../bloc/notification_count_cubit/notification_count_cubit.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    context.read<NotificationCubit>().getData();
    AppSharedPreference.clearNotificationCount();
    context.read<NotificationCountCubit>().changeCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AppProvider.isLogin
            ? BlocBuilder<NotificationCubit, NotificationsInitial>(
                builder: (context, state) {
                  final list = state.result;
                  return RefreshWidget(
                    isLoading: state.loading,
                    child: state.result.isEmpty
                        ? const NotFoundWidget()
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 20.0).h,
                            itemBuilder: (_, i) {
                              return ListTile();
                            },
                            separatorBuilder: (_, i) => 20.0.verticalSpace,
                            itemCount: list.length,
                          ),
                  );
                },
              )
            : NeedLoginWidget());
  }
}
