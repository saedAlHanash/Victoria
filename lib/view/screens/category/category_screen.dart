
import 'package:emarket_user/provider/localization_provider.dart';
import 'package:emarket_user/view/base/footer_web_view.dart';
import 'package:emarket_user/view/base/web_header/web_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:emarket_user/data/model/response/category_model.dart';
import 'package:emarket_user/helper/responsive_helper.dart';
import 'package:emarket_user/provider/category_provider.dart';
import 'package:emarket_user/provider/splash_provider.dart';
import 'package:emarket_user/utill/color_resources.dart';
import 'package:emarket_user/utill/dimensions.dart';
import 'package:emarket_user/utill/images.dart';
import 'package:emarket_user/utill/styles.dart';
import 'package:emarket_user/view/base/no_data_screen.dart';
import 'package:emarket_user/view/base/product_shimmer.dart';
import 'package:emarket_user/view/base/product_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CategoryScreen extends StatefulWidget {
  final CategoryModel categoryModel;
  CategoryScreen({@required this.categoryModel});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> with TickerProviderStateMixin {
  int _tabIndex = 0;
  CategoryModel _categoryModel;

  void _loadData() async {
    _categoryModel = widget.categoryModel;
     Provider.of<CategoryProvider>(context, listen: false).getCategoryList(
      context, true, Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode,
    );
    Provider.of<CategoryProvider>(context, listen: false).getSubCategoryList(
      context, widget.categoryModel.id.toString(), Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode,
    );
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double xyz = MediaQuery.of(context).size.width-Dimensions.WEB_SCREEN_WIDTH ;
    final double realSpaceNeeded =xyz/2;


    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context) ? PreferredSize(child: WebAppBar(), preferredSize: Size.fromHeight(120))  : null,
      body: Consumer<CategoryProvider>(
        builder: (context, category, child) {
          return category.subCategoryList != null ?
          Center(
            child: Scrollbar(
              child: Container(
                // width: Dimensions.WEB_SCREEN_WIDTH,
                child: CustomScrollView(
                  physics: ResponsiveHelper.isDesktop(context) ? AlwaysScrollableScrollPhysics() : BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Theme.of(context).canvasColor,
                      expandedHeight: ResponsiveHelper.isDesktop(context) ? 250 : 200,
                      toolbarHeight: 50 + MediaQuery.of(context).padding.top,
                      pinned: true,
                      floating: false,
                      leading: ResponsiveHelper.isDesktop(context)?SizedBox():Container(width:ResponsiveHelper.isDesktop(context) ? Dimensions.WEB_SCREEN_WIDTH : MediaQuery.of(context).size.width,
                          child: IconButton(icon: Icon(Icons.chevron_left, color: ColorResources.COLOR_WHITE), onPressed: () => Navigator.pop(context))),
                      flexibleSpace: Container(color:Theme.of(context).canvasColor,margin:ResponsiveHelper.isDesktop(context)? EdgeInsets.symmetric(horizontal: realSpaceNeeded):EdgeInsets.symmetric(horizontal: 0),width: ResponsiveHelper.isDesktop(context) ? Dimensions.WEB_SCREEN_WIDTH : MediaQuery.of(context).size.width,
                        child: FlexibleSpaceBar(
                          title: Text(_categoryModel.name??'', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.getWhiteAndBlack(context))),
                          titlePadding: EdgeInsets.only(
                            bottom: 54 + (MediaQuery.of(context).padding.top/2),
                            left: 50,
                            right: 50,
                          ),
                          background: Container(width : ResponsiveHelper.isDesktop(context) ? Dimensions.WEB_SCREEN_WIDTH : MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(bottom: 50),
                            child: FadeInImage.assetNetwork(
                              placeholder: Images.placeholder(context), fit: BoxFit.cover,
                              image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls.categoryBanner}/${_categoryModel.banner!=null?_categoryModel.banner:''??''}',
                              imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder(context), fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(30.0),
                        child: category.subCategoryList != null?Container(
                          width:  ResponsiveHelper.isDesktop(context) ? Dimensions.WEB_SCREEN_WIDTH : MediaQuery.of(context).size.width,
                          color: Theme.of(context).cardColor,
                          child: TabBar(
                            controller: TabController(
                                initialIndex: _tabIndex,
                                length: category.subCategoryList.length+1, vsync: this
                            ),

                            isScrollable: true,
                            unselectedLabelColor: ColorResources.getGreyColor(context),
                            indicatorWeight: 3,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: Theme.of(context).primaryColor,
                            labelColor: Theme.of(context).textTheme.bodyText1.color,
                            tabs: _tabs(category),
                            onTap: (int index) {
                              _tabIndex = index;
                              if(index == 0) {
                                category.getCategoryProductList(context, _categoryModel.id.toString(),Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode,);
                              }else {
                                category.getCategoryProductList(context, category.subCategoryList[index-1].id.toString(),Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode,);
                              }
                            },
                          ),
                        ):SizedBox(),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(minHeight: ResponsiveHelper.isDesktop(context) ? MediaQuery.of(context).size.height -560 : MediaQuery.of(context).size.height),
                            child: Container(width: Dimensions.WEB_SCREEN_WIDTH,
                              child: category.categoryProductList != null ? category.categoryProductList.length > 0 ? GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: ResponsiveHelper.isDesktop(context) ? 13 : 5,
                                  mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? 13 : 5,
                                  childAspectRatio: ResponsiveHelper.isDesktop(context) ? (1/1.4) : 4,
                                  crossAxisCount: ResponsiveHelper.isDesktop(context) ? 5 : ResponsiveHelper.isTab(context) ? 2 : 1),
                              itemCount: category.categoryProductList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                              itemBuilder: (context, index) {
                                return ProductWidget(product: category.categoryProductList[index]);
                              },
                            ) : NoDataScreen(isCategory: true) : GridView.builder(
                              shrinkWrap: true,
                              itemCount: 10,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: ResponsiveHelper.isDesktop(context) ? 13 : 5,
                                mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? 13 : 5,
                                childAspectRatio: ResponsiveHelper.isDesktop(context) ? (1/1.4) : 4,
                                crossAxisCount: ResponsiveHelper.isDesktop(context) ? 5 : ResponsiveHelper.isTab(context) ? 2 : 1,
                              ),
                              itemBuilder: (context, index) {
                                return ProductShimmer(isEnabled: category.categoryProductList == null,isWeb:  ResponsiveHelper.isDesktop(context) ? true : false);
                              },
                            ),
                              ),
                          ),

                          ResponsiveHelper.isDesktop(context) ? FooterView() : SizedBox(),

                        ],
                      ),
                    ),



                  ],
                ),
              ),
            ),
          ) : SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: Dimensions.WEB_SCREEN_WIDTH,
                child: Column(
                  children: [
                    Shimmer(
                        duration: Duration(seconds: 2),
                        enabled: true,
                        child: Container(height: 200,width: double.infinity,color: Colors.grey[300])),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: ResponsiveHelper.isDesktop(context) ? 13 : 5,
                        mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? 13 : 5,
                        childAspectRatio: ResponsiveHelper.isDesktop(context) ? (1/1.4) : 4,
                        crossAxisCount: ResponsiveHelper.isDesktop(context) ? 5 : ResponsiveHelper.isTab(context) ? 2 : 1,
                      ),
                      itemBuilder: (context, index) {
                        return ProductShimmer(isEnabled: category.categoryProductList == null,isWeb:  ResponsiveHelper.isDesktop(context) ? true : false);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Tab> _tabs(CategoryProvider category) {
    List<Tab> tabList = [];
    tabList.add(Tab(text: 'All'));
    category.subCategoryList.forEach((subCategory) => tabList.add(Tab(text: subCategory.name.length >= 30 ? subCategory.name.substring(0,30 )+ '...' : subCategory.name)));
    return tabList;
  }
}
