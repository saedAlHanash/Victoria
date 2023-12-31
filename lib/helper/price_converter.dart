import 'package:flutter/material.dart';
import 'package:emarket_user/provider/splash_provider.dart';
import 'package:provider/provider.dart';

class PriceConverter {
  static String convertPrice(BuildContext context, num price, {double discount, String discountType, int asFixed = 2}) {
    if(discount != null && discountType != null){
      if(discountType == 'amount') {
        price = price - discount;
      }else if(discountType == 'percent') {
        price = price - ((discount / 100) * price);
      }
    }
    return Provider.of<SplashProvider>(context, listen: false).configModel.currencySymbolPosition == 'left' ? '${Provider.of<SplashProvider>(context, listen: false).configModel.currencySymbol} '
        '${(price).toStringAsFixed(asFixed).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}':

    '${(price).toStringAsFixed(asFixed).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}''${Provider.of<SplashProvider>(context, listen: false).configModel.currencySymbol} ';
  }

  static double convertWithDiscount(BuildContext context, num price, double discount, String discountType) {
    if(discountType == 'amount') {
      price = price - discount;
    }else if(discountType == 'percent') {
      price = price - ((discount / 100) * price);
    }
    return price;
  }

  static double calculation(num amount, num discount, String type, int quantity) {
    num calculatedAmount = 0;
    if(type == 'amount') {
      calculatedAmount = discount * quantity;
    }else if(type == 'percent') {
      calculatedAmount = (discount / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(BuildContext context, num price, num discount, String discountType) {
    return '$discount${discountType == 'percent' ? '%' : Provider.of<SplashProvider>(context, listen: false).configModel.currencySymbol} OFF';
  }
}