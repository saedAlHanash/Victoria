import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:victoria/core/app_theme.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/widgets/my_button.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../data/response/order_response.dart';

class ItemOrderHeader extends StatelessWidget {
  const ItemOrderHeader({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppColorManager.red,
      contentPadding: const EdgeInsets.all(15.0).r,
      leading: RoundImageWidget(
        url: order.products.firstOrNull?.image.firstOrNull,
        height: 50.0.r,
        width: 50.0.r,
      ),
      title: DrawableText(
        text: '#${order.id}',
        size: 16.0.sp,
      ),
      subtitle: DrawableText(
        text: order.total.formatPrice,
        fontFamily: FontManager.bold.name,
      ),
      trailing: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: order.status.color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8.0.r),
        ),
        child: DrawableText(
          text: order.status.name,
          size: 14.0.sp,
          color: order.status.color,
          drawableAlin: DrawableAlin.between,
        ),
      ),
    );
  }
}

class ItemOrderBody extends StatelessWidget {
  const ItemOrderBody({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrderPrices(order: order),
        20.0.verticalSpace,
        Row(
          children: [
            Expanded(child: 0.0.verticalSpace),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RouteName.order,
                  arguments: order.id.toString(),
                );
              },
              child: DrawableText(
                text: S.of(context).reviewOrder,
                drawableAlin: DrawableAlin.withText,
                drawableEnd: ImageMultiType(url: Icons.arrow_forward_ios),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class OrderPrices extends StatelessWidget {
  const OrderPrices({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorManager.f8,
      padding: const EdgeInsets.all(30.0).r,
      child: Column(
        children: [
          DrawableText(
            size: 16.0.sp,
            text: S.of(context).order_summary.toUpperCase(),
            matchParent: true,
            color: AppColorManager.c50,
            drawableAlin: DrawableAlin.between,
            drawableEnd: DrawableText(
              size: 16.0.sp,
              text: order.total.formatPrice,
              color: AppColorManager.c50,
            ),
          ),
          15.0.verticalSpace,
          DrawableText(
            size: 16.0.sp,
            text: S.of(context).additional_service.toUpperCase(),
            matchParent: true,
            color: AppColorManager.c50,
            drawableAlin: DrawableAlin.between,
            drawableEnd: DrawableText(
              size: 16.0.sp,
              text: '0',
              color: AppColorManager.c50,
            ),
          ),
          15.0.verticalSpace,
          DrawableText(
            size: 16.0.sp,
            text: S.of(context).discount.toUpperCase(),
            matchParent: true,
            color: AppColorManager.c50,
            drawableAlin: DrawableAlin.between,
            drawableEnd: DrawableText(
              text: order.discount.formatPrice,
              size: 16.0.sp,
              color: AppColorManager.c50,
            ),
          ),
          15.0.verticalSpace,
          DrawableText(
            size: 16.0.sp,
            text: S.of(context).deliveryPrice.toUpperCase(),
            matchParent: true,
            color: AppColorManager.c50,
            drawableAlin: DrawableAlin.between,
            drawableEnd: DrawableText(
              size: 16.0.sp,
              text: order.deliveryPrice.formatPrice,
              color: AppColorManager.c50,
            ),
          ),
          const Divider(),
          DrawableText(
            size: 20.0.sp,
            text: S.of(context).total,
            matchParent: true,
            color: AppColorManager.c50,
            drawableAlin: DrawableAlin.between,
            drawableEnd: DrawableText(
              size: 20.0.sp,
              text: order.totalWithDeliveryPrice.formatPrice,
              color: AppColorManager.c50,
            ),
          ),
        ],
      ),
    );
  }
}
