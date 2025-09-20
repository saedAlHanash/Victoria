import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:victoria/core/app/app_provider.dart';
import 'package:victoria/core/strings/enum_manager.dart';
import 'package:victoria/core/widgets/app_bar/app_bar_widget.dart';
import 'package:victoria/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:victoria/router/app_router.dart';
import 'package:victoria/services/app_info_service.dart';

import '../../../../../core/strings/app_color_manager.dart';
import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';
import '../../../../profile/bloc/get_me_cubit/get_me_cubit.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      border: Border.all(color: AppColorManager.cardColor),
      borderRadius: BorderRadius.circular(14.0.r),
    );
    return Scaffold(
      body: BlocBuilder<GetMeCubit, GetMeInitial>(
        builder: (context, state) {
          return RefreshWidget(
            onRefresh: () {
              context.read<GetMeCubit>().getData(newData: true);
            },
            isLoading: state.loading,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0).r,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0).r,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.r)),
                  tileColor: AppColorManager.mainColor.withValues(alpha: 0.1),
                  title: DrawableText(
                    fontWeight: FontWeight.bold,
                    size: 16.0.sp,
                    text: state.result.name,
                  ),
                  subtitle: DrawableText(
                    text: state.result.email,
                    color: Colors.black45,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: RoundImageWidget(
                      url: Assets.imagesUser,
                      width: 30.0.r,
                    ),
                  ),
                ),
                20.0.verticalSpace,
                Container(
                  decoration: decoration,
                  child: Column(
                    children: [
                      10.0.verticalSpace,
                      DrawableText(
                        text: S.of(context).account,
                        fontWeight: FontWeight.bold,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ).r,
                        matchParent: true,
                        size: 20.0.sp,
                      ),
                      Divider(),
                      ItemMenu(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.profile).then(
                            (value) {
                              context.read<GetMeCubit>().getData(newData: true);
                            },
                          );
                        },
                        name: S.of(context).editProfile,
                        image: Assets.iconsPerson,
                        trailing: ImageMultiType(
                          url: Icons.arrow_forward_ios,
                          height: 15.0.r,
                        ),
                      ),
                      ItemMenu(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.address);
                        },
                        name: S.of(context).addresses,
                        image: Assets.iconsMap,
                        trailing: ImageMultiType(
                          url: Icons.arrow_forward_ios,
                          height: 15.0.r,
                        ),
                      ),
                      ItemMenu(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.orders);
                        },
                        name: S.of(context).myOrders,
                        image: Assets.iconsBox,
                        trailing: ImageMultiType(
                          url: Icons.arrow_forward_ios,
                          height: 15.0.r,
                        ),
                        withD: false,
                      ),
                    ],
                  ),
                ),
                20.0.verticalSpace,
                Container(
                  decoration: decoration,
                  child: Column(
                    children: [
                      10.0.verticalSpace,
                      DrawableText(
                        text: S.of(context).support,
                        fontWeight: FontWeight.bold,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ).r,
                        matchParent: true,
                        size: 20.0.sp,
                      ),
                      Divider(),
                      ItemMenu(
                        onTap: () {},
                        name: S.of(context).policy,
                        image: Assets.iconsFileList,
                        trailing: ImageMultiType(
                          url: Icons.arrow_forward_ios,
                          height: 15.0.r,
                        ),
                      ),
                      ItemMenu(
                        onTap: () {},
                        name: S.of(context).support,
                        image: Assets.iconsPhoneFlip,
                        trailing: ImageMultiType(
                          url: Icons.arrow_forward_ios,
                          height: 15.0.r,
                        ),
                      ),
                      ItemMenu(
                        onTap: () {
                          AppProvider.logout(withDialog: true);
                        },
                        name: S.of(context).logout,
                        image: ImageMultiType(
                          url: Icons.logout,
                          color: AppColorManager.mainColor,
                        ),
                        trailing: ImageMultiType(
                          url: Icons.arrow_forward_ios,
                          height: 15.0.r,
                        ),
                      ),
                      ItemMenu(
                        onTap: () {},
                        name: S.of(context).buildNumber,
                        subTitle: AppInfoService.fullVersionName,
                      ),
                      ItemMenu(
                        onTap: () {},
                        name: S.of(context).devBy,
                        subTitle: 'الحزمة التقنية',
                        withD: false,
                        trailing: ImageMultiType(
                          url: Assets.imagesBandtechLogo,
                          height: 50.0.h,
                          width: 100.0.w,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ItemMenu extends StatelessWidget {
  const ItemMenu({
    super.key,
    required this.name,
    this.subTitle,
    this.image,
    this.trailing,
    this.withD = true,
    this.onTap,
  });

  final String name;

  final String? subTitle;

  final dynamic image;
  final Function()? onTap;
  final Widget? trailing;
  final bool withD;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0).w,
      padding: const EdgeInsets.symmetric(vertical: 5.0).r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0.r),
        color: Colors.white,
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () => onTap?.call(),
            leading: image == null
                ? null
                : ImageMultiType(
                    height: 24.0.r,
                    width: 24.0.r,
                    url: image,
                  ),
            title: DrawableText(
              text: name,
              fontFamily: FontManager.bold.name,
            ),
            minLeadingWidth: 0,
            subtitle: subTitle == null
                ? null
                : DrawableText(
                    text: subTitle!,
                    size: 12.0.sp,
                    color: Colors.grey,
                  ),
            trailing: trailing,
          ),
          10.0.verticalSpace,
          if (withD)
            Divider(
              height: 0,
              color: AppColorManager.cardColor,
              endIndent: 20.0.w,
              indent: 20.0.w,
            ),
        ],
      ),
    );
  }
}
