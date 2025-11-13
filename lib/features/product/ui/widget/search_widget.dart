import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/products_cubit/products_cubit.dart';
import '../../data/request/filter_product_request.dart';

class SearchProductsWidget extends StatefulWidget {
  const SearchProductsWidget({super.key});

  @override
  State<SearchProductsWidget> createState() => _SearchProductsWidgetState();
}

class _SearchProductsWidgetState extends State<SearchProductsWidget> {
  Timer? _debounce;

  final controller = TextEditingController();

  @override
  void initState() {
    controller.text = context.read<ProductsCubit>().state.mRequest.search ?? '';
    super.initState();
  }

  void _onSearchChanged(String search) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(
      const Duration(seconds: 2),
      () {
        _submitSearchToAPI(search);
      },
    );
  }

  void _submitSearchToAPI(String search) {
    context.read<ProductsCubit>()
      ..setSearch(search)
      ..getData();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyTextFormOutLineWidget(
      controller: controller,
      onChanged: (val) {
        context.read<ProductsCubit>().setSearch(val);
        _onSearchChanged(val);
      },
      iconWidgetLift: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 24.0.h,
            width: 1.0.w,
            color: AppColorManager.cardColor,
          ),
          10.0.horizontalSpace,
          ImageMultiType(url: Assets.iconsSearch),
        ],
      ),
      hint: S.of(context).search_In_All,
      textInputAction: TextInputAction.search,
      onFieldSubmitted: (val) {
        context.read<ProductsCubit>()
          ..setSearch(val)
          ..getData();
      },
    );
  }
}

class SearchDrawer extends StatefulWidget {
  const SearchDrawer({super.key});

  @override
  State<SearchDrawer> createState() => _SearchDrawerState();
}

class _SearchDrawerState extends State<SearchDrawer> {
  final controller = TextEditingController();

  void search() {
    final val = controller.text;
    if (val.isEmpty) return;
    Navigator.pushNamed(
      context,
      RouteName.search,
      arguments: [
        SearchRequest(search: val),
        S.of(context).search,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyTextFormOutLineWidget(
      controller: controller,
      hint: 'بحث منتجات .......',
      textInputAction: TextInputAction.search,
      onFieldSubmitted: (val) => search(),
      iconWidgetLift: InkWell(
        onTap: search,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 24.0.h,
              width: 1.0.w,
              color: AppColorManager.cardColor,
            ),
            10.0.horizontalSpace,
            ImageMultiType(url: Assets.iconsSearch),
          ],
        ),
      ),
    );
  }
}
