import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/core/api_manager/api_service.dart';
import 'package:victoria/core/app/app_provider.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/strings/enum_manager.dart';
import 'package:victoria/core/util/shared_preferences.dart';
import 'package:victoria/core/widgets/app_bar/app_bar_widget.dart';
import 'package:victoria/core/widgets/refresh_widget/refresh_widget.dart';

import '../../../../core/app/app_widget.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/need_login_widget.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/all_notification_cubit/all_notification_cubit.dart';

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
    super.initState();
  }

  @override
  void dispose() {
    ctx!.read<NotificationCubit>().getData(newData: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppProvider.isLogin
          ? BlocConsumer<NotificationCubit, NotificationsInitial>(
              listenWhen: (p, c) => c.done,
              listener: (context, state) {
                context.read<NotificationCubit>().readAll();
              },
              builder: (context, state) {
                final gList = state.result.groupListsBy((element) => element.createdAt?.formatDate).values.toList();

                return RefreshWidget(
                  isLoading: state.loading,
                  onRefresh: () {
                    context.read<NotificationCubit>().getData();
                  },
                  child: AppProvider.isGuest
                      ? NeedLoginWidget()
                      : state.isDataEmpty
                          ? const NotFoundWidget()
                          : ListView.separated(
                              itemCount: gList.length,
                              separatorBuilder: (context, i) => 10.0.verticalSpace,
                              itemBuilder: (context, i) {
                                final list = gList[i];
                                loggerObject.w(list.length);
                                if (list.isEmpty) return 0.0.verticalSpace;
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          DrawableText(text: list.first.createdAt?.formatDate ?? '-'),
                                          Expanded(child: Divider()),
                                        ],
                                      ),
                                    ),
                                    ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.all(20.0).r,
                                      physics: NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, i) => 10.0.verticalSpace,
                                      itemCount: list.length,
                                      itemBuilder: (_, i) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(vertical: 10.0).r,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10.0.r),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12.withValues(alpha: 0.1),
                                                offset: Offset(0, 5),
                                                blurRadius: 8,
                                              ),
                                            ],
                                          ),
                                          child: ListTile(
                                            onTap: () {
                                              if (!list[i].notification.productId.isBlankNumber) {
                                                Navigator.pushNamed(
                                                  context,
                                                  RouteName.product,
                                                  arguments: list[i].notification.productId,
                                                );
                                              } else if (!list[i].notification.orderId.isBlankNumber) {
                                                Navigator.pushNamed(
                                                  context,
                                                  RouteName.order,
                                                  arguments: list[i].notification.orderId,
                                                );
                                              }
                                            },
                                            leading: ImageMultiType(url: Assets.iconsNotificationCardIcon),
                                            title: DrawableText(
                                              text: list[i].notification.title,
                                              maxLines: 2,
                                              textAlign: TextAlign.start,
                                              fontFamily: FontManager.bold.name,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            subtitle: DrawableText(
                                              text: list[i].notification.body,
                                              maxLines: 2,
                                              size: 12.0.sp,
                                              color: Colors.grey,
                                              textAlign: TextAlign.start,
                                            ),
                                            trailing: DrawableText(
                                              text: list[i].createdAt?.formatDuration() ?? '-',
                                              size: 10.0.sp,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const DrawableText(text: 'يرجى تسجيل الدخول للمتابعة'),
                  20.0.verticalSpace,
                  MyButton(
                    text: 'تسجيل الدخول',
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context, RouteName.login, (route) => false);
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
