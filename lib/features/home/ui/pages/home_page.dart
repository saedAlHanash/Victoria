import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/core/widgets/app_bar/app_bar_widget.dart';
import 'package:victoria/features/cart/ui/pages/cart_screen.dart';
import 'package:victoria/features/favorite/ui/pages/favorites_page.dart';
import 'package:victoria/features/notification/ui/pages/notification_page.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import '../../../product/data/request/filter_product_request.dart';
import '../../bloc/home_cubit/home_cubit.dart';
import '../widget/bottom_nav_widget.dart';
import '../widget/screens/menu_screen.dart';
import '../widget/screens/search_drawer.dart';
import 'home_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  HomeCubit get cubit => context.read<HomeCubit>();

  @override
  void dispose() {
    cubit.state.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeInitial>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarWidget(
            titleText: state.getLabel,
            color: Colors.white,
            onPopInvoked: (isPop, result) => cubit.jumpPage(0),
            canPop: cubit.canPop,
          ),
          drawer: state.getIndex != 0 ? null : HomeDrawer(),
          bottomNavigationBar: NewNav(),
          body: BlocBuilder<DeleteAccountCubit, DeleteAccountInitial>(
            buildWhen: (p, c) => c.done,
            builder: (context, dState) {
              if (dState.loading) {
                return MyStyle.loadingWidget();
              }
              return PageView(
                controller: state.controller,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const HomeScreen(),
                  const CartScreen(),
                  FavoritesPage(),
                  NotificationPage(),
                  MenuScreen(),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
