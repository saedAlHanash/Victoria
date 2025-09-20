import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/helper/launcher_helper.dart';
import 'package:victoria/core/strings/enum_manager.dart';
import 'package:victoria/core/util/pair_class.dart';
import 'package:victoria/core/widgets/my_button.dart';

import '../api_manager/api_service.dart';
import '../app/app_provider.dart';

late final PackageInfo appData;

num get appBuildNum => num.tryParse(appData.buildNumber) ?? 1000;

Future<bool> checkForceUpdate() async {
  return false;
  final pair = await _apiSettings();

  if (pair.first == null) return false;

  AppProvider.setSetting = (pair.first!);

  if (AppControl.isTestMode) return false;

  if (Platform.isIOS) {
    return appBuildNum < pair.first!.mainAppVersionIos;
  } else {
    return appBuildNum < pair.first!.mainAppVersionAndroid;
  }
}

Future<Pair<SettingResult?, String?>> _apiSettings() async {
  final response = await APIService().callApi(
    type: ApiType.get,
    url: 'system-parameters',
  );

  if (response.statusCode == 200) {
    final data = SettingResult.fromJson(response.jsonBodyPure);

    return Pair(data, null);
  } else {
    return Pair(null, '');
  }
}

Future<bool> showUpdateDialog(BuildContext context,
    {required Widget child, bool? callable, Function(bool b)? omCancel}) async {
// show the dialog
  final result = await showDialog(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.3),
    barrierDismissible: false,
    builder: (BuildContext context) => child,
  );
  omCancel?.call(result ?? false);

  return (result ?? false);
}

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('تحديث جديد متاح'),
      content: const Text('اصدار جديد من التطبيق يجب تحديث التطبيق للمتابعة'),
      actions: [
        MyButton(
          onTap: () {
            LauncherHelper.openPage(AppProvider.systemParams.updateLink);
          },
          text: 'تحديث',
        ),
      ],
    );
  }
}

class AppControl {
  static bool get isTestMode =>
      AppProvider.systemParams.isIosTest &&
      (appBuildNum >
          (Platform.isAndroid
              ? AppProvider.systemParams.mainAppVersionAndroid
              : AppProvider.systemParams.mainAppVersionIos));
}

class SettingResult {
  SettingResult({
    required this.mainAppVersionAndroid,
    required this.mainAppVersionIos,
    required this.isIosTest,
    required this.androidLink,
    required this.androidDirectLink,
    required this.policyLink,
    required this.communication,
    required this.iosLink,
    required this.directLink,
    required this.communicationWithSupport,
  });

  final num mainAppVersionAndroid;
  final num mainAppVersionIos;
  final String androidLink;
  final String androidDirectLink;
  final String policyLink;
  final String communication;
  final String iosLink;
  final String directLink;
  final bool isIosTest;

  final String communicationWithSupport;

  String get updateLink => Platform.isAndroid ? androidLink : iosLink;

  factory SettingResult.fromJson(Map<String, dynamic> json) {
    return SettingResult(
      mainAppVersionAndroid: (json["main_app_version"]).toString().tryParseOr(0),
      mainAppVersionIos: (json["main_app_version_ios"]).toString().tryParseOr(0),
      androidLink: json["app_android_link"] ?? "",
      androidDirectLink: json["app_android_direct_link"] ?? "",
      policyLink:
          json["policy_and_privacy_link"] ?? "https://drive.google.com/file/d/1JzXuo00HdK-Uy-tkRbtCCvjuWcumnk91",
      communication: json["communication_with_support"] ?? 'https://wa.me/9647738000065',
      iosLink: json["app_ios_link"] ?? "",
      directLink: json["directLink"] ?? '',
      isIosTest:
          (json["ios_test"] == null) ? true : ((json["ios_test"] is num) ? json["ios_test"] == 1 : json["ios_test"]),
      communicationWithSupport: json["communication_with_support"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "main_app_version": mainAppVersionAndroid,
        "main_app_version_ios": mainAppVersionIos,
        "app_android_link": androidLink,
        "app_android_direct_link": androidDirectLink,
        "policy_and_privacy_link": policyLink,
        "communication_with_support": communication,
        "app_ios_link": iosLink,
        "directLink": directLink,
        "ios_test": isIosTest,
      };
}
