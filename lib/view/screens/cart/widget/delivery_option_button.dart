import 'package:flutter/material.dart';

import 'package:emarket_user/helper/price_converter.dart';
import 'package:emarket_user/provider/order_provider.dart';
import 'package:emarket_user/provider/splash_provider.dart';
import 'package:emarket_user/utill/dimensions.dart';
import 'package:emarket_user/utill/styles.dart';
import 'package:provider/provider.dart';

class DeliveryOptionButton extends StatelessWidget {
  final String value;
  final String title;
  final bool kmWiseFee;

  DeliveryOptionButton(
      {@required this.value, @required this.title, @required this.kmWiseFee});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, order, child) {

        var s = PriceConverter.convertPrice(
          context,
          Provider.of<SplashProvider>(context, listen: false)
              .configModel
              .deliveryChargeBaghdad,);
        var s1 =  PriceConverter.convertPrice(
          context,
          Provider.of<SplashProvider>(context, listen: false)
              .configModel
              .deliveryChargeOther,
        );
        print(s);
        print(s1);
        var text = value == 'baghdad'
            ? s
            : s1;
        return InkWell(
          onTap: () => order.setOrderType('delivery'),
          child: Row(
            children: [
              Radio(
                value: value,
                groupValue: order.orderType,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (String value) => order.setOrderType(value),
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Text(title, style: rubikRegular),
              SizedBox(width: 5),
              kmWiseFee
                  ? SizedBox()
                  //TODO: ازالة كلمة حر
                  :
                  // Text(
                  //         '(${value == 'delivery'
                  //             ? PriceConverter.convertPrice(context, Provider.of<SplashProvider>(context, listen: false).configModel.deliveryCharge)
                  //             : getTranslated('free', context)})',
                  //         style: rubikMedium,
                  //       ),
                  Text('($text)', style: rubikMedium),
            ],
          ),
        );
      },
    );
  }
}
