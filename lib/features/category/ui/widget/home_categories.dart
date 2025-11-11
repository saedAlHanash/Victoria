// Section title with optional action
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/core/strings/app_color_manager.dart';
import 'package:victoria/core/widgets/see_all_header.dart';
import 'package:victoria/features/product/data/request/filter_product_request.dart';

import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/categories_cubit/categories_cubit.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SeeAllHeader(
          title: S.of(context).sections,
          // onTap: () {
          //   Navigator.pushNamed(
          //     context,
          //     RouteName.categories,
          //   );
          // },
        ),
        Container(
          height: 75.0.h,
          decoration: BoxDecoration(
            border: Border.all(color: AppColorManager.cardColor),
            borderRadius: BorderRadius.circular(12.0.r),
          ),
          padding: EdgeInsets.all(7.0).r,
          margin: EdgeInsets.symmetric(vertical: 7.0).r,
          child: BlocBuilder<CategoriesCubit, CategoriesInitial>(
            builder: (context, state) {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  final e = state.result[i];
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColorManager.cardColor,
                      borderRadius: BorderRadius.circular(12.0).r,
                    ),
                    clipBehavior: Clip.hardEdge,
                    width: 0.2.sw,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteName.products,
                          arguments: [FilterProductRequest(category: e), S.of(context).products],
                        );
                      },
                      child: Stack(
                        children: [
                          ImageMultiType(
                            url: e.image,
                            height: 1.0.sh,
                            width: 1.0.sw,
                            fit: BoxFit.cover,
                          ),
                          Align(
                            alignment: AlignmentGeometry.bottomCenter,
                            child: Container(
                              width: 1.0.sw,
                              color: Colors.black38,
                              constraints: BoxConstraints(maxHeight: 35.0.h, minHeight: 15.0.h),
                              child: DrawableText(
                                text: e.name,
                                matchParent: true,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                color: Colors.white,
                                size: 12.0.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, i) => 10.0.horizontalSpace,
                itemCount: state.result.length,
              );
            },
          ),
        )
      ],
    );
  }
}
