import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/widgets/not_found_widget.dart';
import 'package:victoria/features/category/ui/widget/item_category.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../category/bloc/categories_cubit/categories_cubit.dart';
import '../../bloc/products_cubit/products_cubit.dart';
import '../widget/item_product.dart';
import '../widget/search_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});

  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _scrollController = ScrollController();
  var loadingNewData = false;

  ProductsCubit get cubit => context.read<ProductsCubit>();

  CategoriesCubit get cCubit => context.read<CategoriesCubit>();

  void scrollListener() {
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 5) {
      context.read<ProductsCubit>().getNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(scrollListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoriesCubit, CategoriesInitial>(
      listenWhen: (p, c) => c.done,
      listener: (context, state) {
        if (state.mRequest.id.isBlankNumber) return;
        if (state.result.isNotEmpty) {
          context.read<ProductsCubit>()
            ..setCategory(state.result.first)
            ..getData();
        }
      },
      child: Scaffold(
        appBar: AppBarWidget(titleText: widget.title, elevation: 0),
        body: BlocConsumer<ProductsCubit, ProductsInitial>(
          listener: (context, state) {
            if (state.done && state.meta.haveNext) {
              _scrollController.addListener(scrollListener);
            } else {
              _scrollController.removeListener(scrollListener);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  SearchProductsWidget(),
                  if (!cCubit.state.mRequest.id.isBlankNumber) _Cat(),
                  Expanded(
                    child: state.isDataEmpty
                        ? NotFoundWidget()
                        : RefreshWidget(
                            isLoading: state.loading,
                            onRefresh: () => context.read<ProductsCubit>().getData(newData: true),
                            child: state.isDataEmpty
                                ? NotFoundWidget()
                                : GridView.builder(
                                    controller: _scrollController,
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

class _Cat extends StatelessWidget {
  const _Cat();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsInitial>(
      builder: (context, state) {
        return Container(
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
                  final category = cState.result[i];
                  return ItemCategory(
                    selected: state.mRequest.category?.id == category.id,
                    category: category,
                    onTap: (category) {
                      if (state.loading) return;
                      context.read<ProductsCubit>().setCategory(category);
                    },
                  );
                },
                separatorBuilder: (context, i) => 10.0.horizontalSpace,
                itemCount: cState.result.length,
              );
            },
          ),
        );
      },
    );
  }
}
