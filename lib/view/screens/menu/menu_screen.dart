import 'package:emarket_user/helper/responsive_helper.dart';
import 'package:emarket_user/view/base/web_header/web_app_bar.dart';
import 'package:emarket_user/view/screens/menu/web/menu_screen_web.dart';
import 'package:emarket_user/view/screens/menu/widget/options_view.dart';
import 'package:flutter/material.dart';
import 'package:emarket_user/localization/language_constrants.dart';
import 'package:emarket_user/provider/auth_provider.dart';
import 'package:emarket_user/provider/profile_provider.dart';
import 'package:emarket_user/provider/splash_provider.dart';
import 'package:emarket_user/utill/color_resources.dart';
import 'package:emarket_user/utill/dimensions.dart';
import 'package:emarket_user/utill/images.dart';
import 'package:emarket_user/utill/styles.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  final Function onTap;

  MenuScreen({this.onTap});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool _isLoggedIn;

  @override
  void initState() {
    _isLoggedIn = Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if (_isLoggedIn) {
      Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context)
          ? PreferredSize(child: WebAppBar(), preferredSize: Size.fromHeight(120))
          : null,
      body: ResponsiveHelper.isDesktop(context)
          ? MenuScreenWeb(isLoggedIn: _isLoggedIn)
          : Column(children: [
              Consumer<ProfileProvider>(
                builder: (context, profileProvider, child) => Center(
                  child: Container(
                    width: 1170,
                    padding: EdgeInsets.symmetric(vertical: 50),
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: ColorResources.COLOR_WHITE, width: 2)),
                        child: ClipOval(
                          child: _isLoggedIn
                              ? FadeInImage.assetNetwork(
                                  placeholder: Images.placeholder(context),
                                  image: '${Provider.of<SplashProvider>(
                                    context,
                                  ).baseUrls.customerImageUrl}/'
                                      '${profileProvider.userInfoModel != null ? profileProvider.userInfoModel.image : ''}',
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                  imageErrorBuilder: (c, o, s) => Image.asset(
                                      Images.placeholder(context),
                                      fit: BoxFit.cover),
                                )
                              : Image.asset(Images.placeholder(context),
                                  height: 80, width: 80, fit: BoxFit.cover),
                        ),
                      ),
                      Column(children: [
                        SizedBox(height: 20),
                        _isLoggedIn
                            ? profileProvider.userInfoModel != null
                                ? Text(
                                    '${profileProvider.userInfoModel.fName ?? ''} ${profileProvider.userInfoModel.lName ?? ''}',
                                    style: rubikRegular.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                                        color: ColorResources.COLOR_WHITE),
                                  )
                                : Container(
                                    height: 15, width: 150, color: Colors.grey[300])
                            : Text(
                                getTranslated('guest', context),
                                style: rubikRegular.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                                    color: ColorResources.COLOR_WHITE),
                              ),
                        SizedBox(height: 10),
                        _isLoggedIn
                            ? profileProvider.userInfoModel != null
                                ? Text(
                                    '${profileProvider.userInfoModel.email ?? ''}',
                                    style: rubikRegular.copyWith(
                                        color: ColorResources.BACKGROUND_COLOR),
                                  )
                                : Container(
                                    height: 15, width: 100, color: Colors.grey[300])
                            : Text(
                                'demo@demo.com',
                                style: rubikRegular.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                                    color: ColorResources.COLOR_WHITE),
                              ),
                      ])
                    ],),
                  ),
                ),
              ),
              Expanded(child: OptionsView(onTap: widget.onTap)),
            ]),
    );
  }
}
