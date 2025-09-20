import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:victoria/core/strings/app_color_manager.dart';
import 'package:victoria/core/widgets/my_expansion/my_expansion_panal.dart';

import 'item_expansion.dart';

class MyExpansionWidget extends StatefulWidget {
  const MyExpansionWidget({
    super.key,
    required this.items,
    this.onTapItem,
    this.elevation,
    this.onExpansion,
    this.decoration,
  });

  final List<ItemExpansion> items;
  final double? elevation;
  final BoxDecoration? decoration;
  final Function(int, bool)? onTapItem;
  final Function(int panelIndex, bool isExpanded)? onExpansion;

  @override
  State<MyExpansionWidget> createState() => _MyExpansionWidgetState();
}

class _MyExpansionWidgetState extends State<MyExpansionWidget> {
  @override
  Widget build(BuildContext context) {
    final listItem = widget.items.map(
      (e) {
        return MyExpansionPanelRadio(
          canTapOnHeader: true,
          onTapItem: widget.onTapItem,
          backgroundColor: (e.isExpanded && e.withSideColor) ? AppColorManager.lightGray : AppColorManager.white,
          headerBuilder: (_, isExpanded) {
            if (e.headerText != null) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0.r),
                ),
                alignment: Alignment.center,
                child: DrawableText(text: e.headerText!),
              );
            }
            return e.header ?? const DrawableText(text: 'header');
          },
          body: e.body,
          enable: e.enable,
          value: e.id,
        );
      },
    ).toList();

    return MyExpansionPanelList.radio(
      elevation: 0.0,
      cardElevation: 0,
      children: listItem,
      decoration: widget.decoration,
      dividerColor: Colors.transparent,
      expansionCallback: (panelIndex, isExpanded) {
        widget.onExpansion?.call(panelIndex, isExpanded);
        setState(() {
          widget.items[panelIndex].isExpanded = !widget.items[panelIndex].isExpanded;
        });
      },
    );
  }
}
