import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/core/api_manager/api_service.dart';
import 'package:victoria/core/strings/app_color_manager.dart';
import 'package:victoria/core/widgets/my_card_widget.dart';

class CardSlider extends StatelessWidget {
  const CardSlider({
    super.key,
    this.stackChild,
    required this.images,
    this.height,
    this.width,
  });

  final List<Widget>? stackChild;
  final Iterable<String> images;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    final key = GlobalKey<IndicatorSliderWidgetState>();
    widgets.add(
      SizedBox(
        height: height ?? 160.0.h,
        width: 1.0.sw,
        child: CarouselSlider(
          items: images.map(
            (e) {
              return ImageMultiType(
                url: e,
                height: 1.0.sh,
                width: width ?? 1.0.sw,
                fit: BoxFit.fill,
              );
            },
          ).toList(),
          options: CarouselOptions(
            autoPlayInterval: const Duration(seconds: 5),
            autoPlay: true,
            viewportFraction: 1,
            onPageChanged: (i, reason) {
              key.currentState!.changePage(i);
            },
          ),
        ),
      ),
    );

    // widgets.add(
    //   Container(
    //     height: height ?? 160.0.h,
    //     width: 1.0.sw,
    //     color: Colors.black12,
    //   ),
    // );

    widgets.add(
      Positioned(
        bottom: 15.0.h,
        child: IndicatorSliderWidget(
          key: key,
          length: images.length,
        ),
      ),
    );
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: widgets,
      ),
    );
  }
}

class CardImageSlider extends StatefulWidget {
  const CardImageSlider({
    super.key,
    this.margin,
    this.stackChild,
    required this.images,
    this.height,
    this.width,
    this.onChange,
    this.card = false,
  });

  final EdgeInsets? margin;
  final List<Widget>? stackChild;
  final List<Widget> images;
  final double? height;
  final double? width;
  final bool card;
  final Function()? onChange;

  @override
  State<CardImageSlider> createState() => CardImageSliderState();
}

class CardImageSliderState extends State<CardImageSlider> {
  late final CarouselSliderController controller;

  late int currentImage;

  void setIndex(int i) {
    key.currentState?.changePage(i);
    currentImage = i;
    controller.animateToPage(currentImage);
  }

  @override
  void initState() {
    controller = CarouselSliderController();
    currentImage = 0;
    super.initState();
  }

  final key = GlobalKey<IndicatorSliderWidgetState>();

  @override
  Widget build(BuildContext context) {
    Widget widgetSlider = SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              carouselController: controller,
              items: widget.images.map(
                (e) {
                  return ImageMultiType(
                    url: e,
                    width: widget.width ?? 1.0.sw,
                    height: 1.0.sh,
                    fit: BoxFit.contain,
                  );
                },
              ).toList(),
              options: CarouselOptions(
                autoPlayInterval: const Duration(seconds: 15),
                height: widget.height,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                onPageChanged: (i, reason) {
                  key.currentState!.changePage(i);
                  currentImage = i;
                  widget.onChange?.call();
                },
              ),
            ),
          ),
          10.0.verticalSpace,
          IndicatorSliderWidget(
            key: key,
            length: widget.images.length,
            selectedColor: AppColorManager.mainColor,
            unselectedColor: Colors.grey,
          ),
        ],
      ),
    );
    if (widget.card) {
      widgetSlider = MyCardWidget(
        padding: EdgeInsets.zero,
        margin: widget.margin,
        cardColor: Colors.white,
        elevation: 0.0,
        child: widgetSlider,
      );
    }
    return widgetSlider;
  }
}

class IndicatorSliderWidget extends StatefulWidget {
  const IndicatorSliderWidget({
    super.key,
    required this.length,
    this.selectedColor,
    this.unselectedColor,
  });

  final int length;
  final Color? selectedColor;
  final Color? unselectedColor;

  @override
  State<IndicatorSliderWidget> createState() => IndicatorSliderWidgetState();
}

class IndicatorSliderWidgetState extends State<IndicatorSliderWidget> {
  late int selected;

  void changePage(int i) {
    setState(() => selected = i);
  }

  @override
  void initState() {
    selected = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.length < 2) return 0.0.verticalSpace;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.0).r,
      height: 12.0.h,
      child: ListView.separated(
        itemCount: widget.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          // return ImageMultiType(url: Icons.celebration);
          return AnimatedContainer(
            height: 5.0.h,
            margin: EdgeInsets.symmetric(vertical: 2.0),
            width: selected == i ? 15.0.w : 8.0.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: selected == i
                    ? (widget.selectedColor ?? AppColorManager.mainColor)
                    : (widget.unselectedColor ?? Colors.white)),
            duration: const Duration(milliseconds: 150),
          );
        },
        separatorBuilder: (context, i) => 5.0.horizontalSpace,
      ),
    );
  }
}
