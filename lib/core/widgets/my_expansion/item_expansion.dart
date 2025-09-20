import 'package:flutter/material.dart';
import 'package:victoria/core/strings/app_color_manager.dart';

class ItemExpansion {
  ItemExpansion({
    this.headerText,
    this.header,
    this.withSideColor = false,
    required this.body,
    this.isExpanded = false,
    this.enable = true,
    this.id = 0,
    this.additional,
  });

  final Widget? header;
  final String? headerText;
  final Widget body;
  bool isExpanded;
  bool enable;
  int id;
  bool withSideColor;
  String? additional;
}

class ItemExpansionOption {
  ItemExpansionOption({
    this.withSideColor = false,
    this.color = AppColorManager.white,
  });

  bool withSideColor;
  Color color;
}
