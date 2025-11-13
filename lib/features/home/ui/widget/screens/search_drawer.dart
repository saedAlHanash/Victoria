import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:victoria/core/strings/app_color_manager.dart';
import 'package:victoria/core/widgets/my_text_form_widget.dart';

import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../router/app_router.dart';
import '../../../../category/bloc/categories_cubit/categories_cubit.dart';
import '../../../../product/bloc/products_cubit/products_cubit.dart';
import '../../../../product/data/request/filter_product_request.dart';
import '../../../../product/ui/widget/search_widget.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 1,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchDrawer(),
              Transform.scale(
                scaleX: 1.5,
                child: Divider(),
              ),
              15.0.verticalSpace,
              DrawableText(text: '${S.of(context).categories}: '),
              10.0.verticalSpace,
              Expanded(
                child: BlocBuilder<CategoriesCubit, CategoriesInitial>(
                  builder: (context, state) {
                    return ListView.builder(
                      itemCount: state.result.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteName.search,
                              arguments: [
                                SearchRequest(category: state.result[i]),
                                state.result[i].name,
                              ],
                            );
                          },
                          child: DrawableText(
                            text: state.result[i].name,
                            drawablePadding: 10.0,
                            padding: EdgeInsets.symmetric(vertical: 10.0).r,
                            drawableStart: RoundImageWidget(
                              radios: 12.0.r,
                              url: state.result[i].image,
                              height: 35.0.dg,
                              width: 35.0.dg,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
