import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/features/home/bloc/home_cubit/home_cubit.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';

class Navbar extends StatefulWidget {
  const Navbar({
    super.key,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: AppColorManager.white,
      fontSize: 12.0.sp,
      fontFamily: FontManager.bold.name,
    );
    return BlocBuilder<HomeCubit, HomeInitial>(
      builder: (context, state) {
        return CurvedNavigationBar(
          index: context.read<HomeCubit>().getIndex,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          color: AppColorManager.mainColor,
          buttonBackgroundColor: AppColorManager.mainColor,
          items: [
            CurvedNavigationBarItem(
              child: ImageMultiType(
                url: Assets.iconsHome,
                color: Colors.white,
                height: 25.0.r,
                width: 25.0.r,
              ),
              label: S.of(context).home,
              labelStyle: style,
            ),
            CurvedNavigationBarItem(
              child: ImageMultiType(
                url: Assets.iconsCart,
                color: Colors.white,
                height: 25.0.r,
                width: 25.0.r,
              ),
              label: S.of(context).cart,
              labelStyle: style,
            ),
            CurvedNavigationBarItem(
              child: ImageMultiType(
                url: Assets.iconsHeart,
                color: Colors.white,
                height: 25.0.r,
                width: 25.0.r,
              ),
              label: S.of(context).fav,
              labelStyle: style,
            ),
            CurvedNavigationBarItem(
              child: ImageMultiType(
                url: Assets.iconsNotification,
                color: Colors.white,
                height: 25.0.r,
                width: 25.0.r,
              ),
              label: S.of(context).notification,
              labelStyle: style,
            ),
            CurvedNavigationBarItem(
              child: ImageMultiType(
                url: Assets.iconsPerson,
                color: Colors.white,
                height: 25.0.r,
                width: 25.0.r,
              ),
              label: S.of(context).profile,
              labelStyle: style,
            ),
          ],
          onTap: (index) {
            context.read<HomeCubit>().jumpPage(index);
          },
        );
      },
    );
  }
}

class NewNav extends StatefulWidget {
  const NewNav({super.key});

  @override
  State<NewNav> createState() => _NewNavState();
}

class _NewNavState extends State<NewNav> {
  BottomNavigationBarItem getItem(dynamic icon, dynamic iconF, dynamic label) => BottomNavigationBarItem(
        icon: ImageMultiType(
          url: icon,
          color: AppColorManager.mainColor,
          height: 25.0.spMin,
        ),
        activeIcon: ImageMultiType(
          url: iconF,
          color: AppColorManager.mainColor,
          height: 25.0.spMin,
        ),
        label: label,
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeInitial>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(top: 7.0, bottom: 5.0).r,
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border(
            //   top: BorderSide(color: AppColorManager.dividerColor),
            // ),
          ),
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              backgroundColor: AppColorManager.white,
              fixedColor: AppColorManager.mainColor,
              unselectedItemColor: AppColorManager.mainColor,
              elevation: 0,
              selectedLabelStyle: TextStyle(
                color: AppColorManager.mainColor,
                fontFamily: FontManager.semeBold.name,
              ),
              unselectedLabelStyle: TextStyle(
                color: AppColorManager.mainColor,
                fontFamily: FontManager.semeBold.name,
              ),
              items: [
                getItem(Assets.iconsHome, Assets.iconsHomeF, S.of(context).home),
                getItem(Assets.iconsCart, Assets.iconsCartF, S.of(context).cart),
                getItem(Assets.iconsHeart, Assets.iconsHeartF, S.of(context).fav),
                getItem(Assets.iconsNotification, Assets.iconsNotificationF, S.of(context).notification),
                getItem(Assets.iconsPerson, Assets.iconsPersonF, S.of(context).profile),
              ],
              currentIndex: state.getIndex,
              onTap: (i) {
                context.read<HomeCubit>().jumpPage(i);
              },
              type: BottomNavigationBarType.fixed,
            ),
          ),
        );
      },
    );
  }
}
