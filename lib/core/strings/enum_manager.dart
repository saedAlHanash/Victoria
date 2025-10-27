import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:victoria/core/api_manager/api_service.dart';

import '../../generated/l10n.dart';
import '../util/pair_class.dart';
import 'app_color_manager.dart';

enum StartPage { login, home, signupOtp, passwordOtp }

enum GenderEnum {
  male,
  female;

  String get name {
    switch (this) {
      case GenderEnum.male:
        return 'ذكر';
      case GenderEnum.female:
        return 'أنثى';
    }
  }

  String get nameApi {
    switch (this) {
      case GenderEnum.male:
        return 'male';
      case GenderEnum.female:
        return 'female';
    }
  }
}

enum IraqGovernorate {
  baghdad,
  basra,
  nineveh,
  erbil,
  sulaymaniyah,
  dhiQar,
  anbar,
  najaf,
  karbala,
  diyala,
  muthanna,
  salahaddin,
  babil,
  kirkuk,
  wasit,
  dahuk,
  diwaniyah,
  maysan;

  LatLng get getGovernorateLatLng {
    switch (this) {
      case IraqGovernorate.baghdad:
        return LatLng(33.3152, 44.3661);
      case IraqGovernorate.basra:
        return LatLng(30.5085, 47.7804);
      case IraqGovernorate.nineveh:
        return LatLng(36.3350, 43.1189);
      case IraqGovernorate.erbil:
        return LatLng(36.1900, 44.0090);
      case IraqGovernorate.sulaymaniyah:
        return LatLng(35.5610, 45.4408);
      case IraqGovernorate.dhiQar:
        return LatLng(31.0420, 46.2570);
      case IraqGovernorate.anbar:
        return LatLng(33.4200, 43.3000);
      case IraqGovernorate.najaf:
        return LatLng(31.9950, 44.3140);
      case IraqGovernorate.karbala:
        return LatLng(32.6160, 44.0240);
      case IraqGovernorate.diyala:
        return LatLng(33.7500, 44.6400);
      case IraqGovernorate.muthanna:
        return LatLng(31.3090, 45.2800);
      case IraqGovernorate.salahaddin:
        return LatLng(34.6110, 43.6780);
      case IraqGovernorate.babil:
        return LatLng(32.4720, 44.4210);
      case IraqGovernorate.kirkuk:
        return LatLng(35.4680, 44.3920);
      case IraqGovernorate.wasit:
        return LatLng(32.5000, 45.8200);
      case IraqGovernorate.dahuk:
        return LatLng(36.8670, 42.9880);
      case IraqGovernorate.diwaniyah:
        return LatLng(31.9870, 44.9240);
      case IraqGovernorate.maysan:
        return LatLng(31.8350, 47.1440);
    }
  }

  String get name {
    switch (this) {
      case IraqGovernorate.baghdad:
        return 'بغداد';
      case IraqGovernorate.basra:
        return 'البصرة';
      case IraqGovernorate.nineveh:
        return 'نينوى';
      case IraqGovernorate.erbil:
        return 'أربيل';
      case IraqGovernorate.sulaymaniyah:
        return 'السليمانية';
      case IraqGovernorate.dhiQar:
        return 'ذي قار';
      case IraqGovernorate.anbar:
        return 'الأنبار';
      case IraqGovernorate.najaf:
        return 'النجف';
      case IraqGovernorate.karbala:
        return 'كربلاء';
      case IraqGovernorate.diyala:
        return 'ديالى';
      case IraqGovernorate.muthanna:
        return 'المثنى';
      case IraqGovernorate.salahaddin:
        return 'صلاح الدين';
      case IraqGovernorate.babil:
        return 'بابل';
      case IraqGovernorate.kirkuk:
        return 'كركوك';
      case IraqGovernorate.wasit:
        return 'واسط';
      case IraqGovernorate.dahuk:
        return 'دهوك';
      case IraqGovernorate.diwaniyah:
        return 'الديوانية';
      case IraqGovernorate.maysan:
        return 'ميسان';
    }
  }

  static IraqGovernorate getByName(String name) {
    return IraqGovernorate.values.firstWhere(
      (g) => g.name == name,
      orElse: () => IraqGovernorate.baghdad,
    );
  }

  static IraqGovernorate getByApproximateName(String inputName) {
    inputName = inputName.trim();

    IraqGovernorate? bestMatch;
    double bestScore = 0;

    for (final gov in IraqGovernorate.values) {
      final score = StringSimilarity.compareTwoStrings(inputName, gov.name);
      if (score > bestScore) {
        bestScore = score;
        bestMatch = gov;
      }
    }

    // حدد الحد الأدنى لقبول التشابه (مثلاً 0.6)
    if (bestScore >= 0.6 && bestMatch != null) {
      return bestMatch;
    }

    return IraqGovernorate.baghdad;
  }
}

enum ApiType {
  get,
  post,
  put,
  patch,
  delete,
}

enum GetProductsType { non, topSell, latest, offers }

enum SortBy {
  price,
  createdAt;

  String get name {
    switch (this) {
      case SortBy.price:
        return S().price;
      case SortBy.createdAt:
        return S().latest;
    }
  }

  String get nameApi {
    switch (this) {
      case SortBy.price:
        return 'price';
      case SortBy.createdAt:
        return 'created_at';
    }
  }
}

enum SortOrder {
  asc,
  desc;

  String get name {
    switch (this) {
      case SortOrder.asc:
        return S().ascending;
      case SortOrder.desc:
        return S().descending;
    }
  }

  String get nameApi {
    switch (this) {
      case SortOrder.asc:
        return 'asc';
      case SortOrder.desc:
        return 'desc';
    }
  }
}

enum FontManager { regular, semeBold, bold }

enum CouponType {
  fixed,
  percentage;

  static CouponType getByNameOrIndex(String name) {
    final i = int.tryParse(name);
    if (i != null) return CouponType.values[i];
    switch (name.toLowerCase()) {
      case 'fixed':
        return CouponType.fixed;
      case 'percentage':
        return CouponType.percentage;
      default:
        return CouponType.fixed;
    }
  }
}

enum OrderStatus {
  pending,
  accepted,
  completed,
  cancelled,
  returned,
  needPay,
  ;

  Color get color {
    switch (this) {
      case OrderStatus.pending:
      case OrderStatus.accepted:
        return AppColorManager.mainColor;
      case OrderStatus.completed:
        return Colors.green;
      case OrderStatus.cancelled:
      case OrderStatus.returned:
        return Colors.red;
      case OrderStatus.needPay:
        return Colors.grey;
    }
  }

  String get name {
    //S()
    return switch (this) {
      OrderStatus.pending => S().pending,
      OrderStatus.accepted => S().accepted,
      OrderStatus.completed => S().completed,
      OrderStatus.cancelled => S().cancelled,
      OrderStatus.returned => S().returned,
      OrderStatus.needPay => S().needPay,
    };
  }

  static OrderStatus getByNameOrIndex(String name) {

    final i = int.tryParse(name);
    if (i != null) {
      return OrderStatus.values[i];
    }
    return switch (name.toLowerCase()) {
      'pending' => OrderStatus.pending,
      'accepted' => OrderStatus.accepted,
      'completed' => OrderStatus.completed,
      'cancelled' => OrderStatus.cancelled,
      'returned' => OrderStatus.returned,
      'need_pay' => OrderStatus.needPay,
      _ => OrderStatus.pending,
    };
  }
}

enum AdsType {
  banner,
  slider,
  middle,
  last;

  Color get getOrderStateColorText {
    switch (this) {
      case AdsType.banner:
      case AdsType.slider:
        return AppColorManager.mainColor;
      case AdsType.middle:
        return Colors.green;
      case AdsType.last:
        return Colors.red;
    }
  }

  static AdsType getByNameOrIndex(String name) {
    final i = int.tryParse(name);
    if (i != null) {
      // Ensure the index is within the valid range
      if (i >= 0 && i < AdsType.values.length) {
        return AdsType.values[i];
      } else {
        // Handle invalid index, perhaps return a default or throw an error
        return AdsType.banner; // Or throw ArgumentError('Invalid index for AdsType');
      }
    }
    return switch (name.toLowerCase()) {
      'slider' => AdsType.slider,
      'banner1' => AdsType.banner,
      'banner2' => AdsType.middle,
      'banner3' => AdsType.last,
      _ => AdsType.banner, // Default value if name doesn't match
    };
  }
}
