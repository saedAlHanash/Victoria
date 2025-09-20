import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/features/ads/ui/widgets/adds_slider.dart';
import 'package:victoria/features/product/ui/widget/general_products.dart';
import 'package:victoria/features/product/ui/widget/latest_products.dart';
import 'package:victoria/features/product/ui/widget/offers_products.dart';
import 'package:victoria/features/product/ui/widget/top_selling_products.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../category/ui/widget/home_categories.dart';
import '../../../product/data/request/filter_product_request.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 120.0).r,
        children: [
          12.0.verticalSpace,
          AddsSlider(type: AdsType.banner),
          20.0.verticalSpace,
          HomeCategories(),
          20.0.verticalSpace,
          TopSellingProducts(),
          20.0.verticalSpace,
          AddsSlider(type: AdsType.slider),
          20.0.verticalSpace,
          LatestProducts(),
          20.0.verticalSpace,
          AddsSlider(type: AdsType.middle),
          20.0.verticalSpace,
          OffersProducts(),
          20.0.verticalSpace,
          AddsSlider(type: AdsType.last, height: 220.0.h),
          20.0.verticalSpace,
          GeneralProducts(),
        ],
      ),
    );
  }
}
