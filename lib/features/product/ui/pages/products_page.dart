import 'dart:async';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/widgets/not_found_widget.dart';
import 'package:victoria/core/widgets/spinner_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../category/bloc/categories_cubit/categories_cubit.dart';
import '../../bloc/products_cubit/products_cubit.dart';
import '../widget/item_product.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key, required this.title, required this.withSearch});

  final String title;
  final bool withSearch;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoriesCubit, CategoriesInitial>(
      listenWhen: (p, c) => c.done,
      listener: (context, state) {
        if (state.result.isNotEmpty) {
          context.read<ProductsCubit>()
            ..setCategory(state.result.first)
            ..getData();
        }
      },
      child: Scaffold(
        appBar: AppBarWidget(titleText: title),
        body: BlocBuilder<ProductsCubit, ProductsInitial>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  if (withSearch) _Search(),
                  Expanded(
                    child: RefreshWidget(
                      isLoading: state.loading,
                      onRefresh: () => context.read<ProductsCubit>().getData(newData: true),
                      child: state.isDataEmpty
                          ? NotFoundWidget()
                          : GridView.builder(
                              padding: EdgeInsets.all(20.0).r,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0.r,
                                mainAxisSpacing: 20.0.r,
                                mainAxisExtent: 220.0.h,
                              ),
                              itemCount: state.result.length,
                              itemBuilder: (_, i) {
                                final item = state.result[i];
                                return ItemProduct(product: item);
                              },
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Search extends StatelessWidget {
  const _Search();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsInitial>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SpinnerWidget(
                    hintText: S.of(context).sortBy,
                    items: SortBy.values.getSpinnerItems(selectedId: state.mRequest.sortBy?.index),
                    onChanged: (spinnerItem) {
                      context.read<ProductsCubit>().setSortBy(spinnerItem.item);
                    },
                  ),
                ),
                10.0.horizontalSpace,
                Expanded(
                  child: SpinnerWidget(
                    hintText: S.of(context).sortOrder,
                    items: SortOrder.values.getSpinnerItems(selectedId: state.mRequest.sortOrder?.index),
                    onChanged: (spinnerItem) {
                      context.read<ProductsCubit>().setSortOrder(spinnerItem.item);
                    },
                  ),
                ),
              ],
            ),
            10.0.verticalSpace,
            SearchProductsWidget(),
            10.0.verticalSpace,
            Container(
              height: 75.0.h,
              decoration: BoxDecoration(
                border: Border.all(color: AppColorManager.cardColor),
                borderRadius: BorderRadius.circular(12.0.r),
              ),
              padding: EdgeInsets.all(7.0).r,
              margin: EdgeInsets.symmetric(vertical: 7.0).r,
              child: BlocBuilder<CategoriesCubit, CategoriesInitial>(
                builder: (context, cState) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      final e = cState.result[i];
                      return Container(
                        width: 0.25.sw,
                        decoration: BoxDecoration(
                          color: state.mRequest.category?.id == e.id ? Colors.grey[100]! : Colors.transparent,
                          borderRadius: BorderRadius.circular(8.0).r,
                        ),
                        child: InkWell(
                          onTap: () {
                            context.read<ProductsCubit>().setCategory(e);
                          },
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ImageMultiType(
                                  height: 30.0.r,
                                  width: 30.0.r,
                                  url: e.image,
                                ),
                                5.0.verticalSpace,
                                DrawableText(
                                  text: e.name,
                                  textAlign: TextAlign.center,
                                  matchParent: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, i) => 10.0.horizontalSpace,
                    itemCount: cState.result.length,
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}

class SearchProductsWidget extends StatefulWidget {
  const SearchProductsWidget({super.key});

  @override
  State<SearchProductsWidget> createState() => _SearchProductsWidgetState();
}

class _SearchProductsWidgetState extends State<SearchProductsWidget> {
  Timer? _debounce;

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
    return MyEditTextWidget(
      onChanged: (val) {
        context.read<ProductsCubit>().setSearch(val);
        _onSearchChanged(val);
      },
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
        child: ImageMultiType(url: Icons.search, color: AppColorManager.gray),
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
