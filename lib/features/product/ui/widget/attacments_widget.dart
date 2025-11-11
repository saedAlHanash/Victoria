import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:victoria/core/strings/app_color_manager.dart';

import '../../../../core/widgets/card_slider_widget.dart';
import '../../data/response/product_response.dart';

class CardAttachmentsSlider extends StatefulWidget {
  const CardAttachmentsSlider({super.key, required this.product});

  final Product product;

  @override
  State<CardAttachmentsSlider> createState() => _CardAttachmentsSliderState();
}

class _CardAttachmentsSliderState extends State<CardAttachmentsSlider> {
  void changAttachment(int i) {
    key.currentState?.setIndex(i);
  }

  final PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    // التأكد من أن الـ PageView قد تم بناءه قبل التفاعل مع الـ controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        setState(() {
          controller.jumpToPage(0);
        });
      } catch (e) {}
    });
  }

  int currentIndex = 0; // مؤشر الصورة الحالية

  @override
  void dispose() {
    super.dispose();
  }

  Widget getAttachment(String image) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: false, // يمنع إغلاق النافذة عند الضغط خارجها
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.all(10), // التحكم في مساحة النافذة
              child: FullscreenImageViewer(
                initialIndex: currentIndex,
                attachments: widget.product.image,
              ),
            );
          },
        );
      },
      child: ImageMultiType(
        url: image,
        fit: BoxFit.contain,
        height: 300.0.h,
      ),
    );
  }

  final key = GlobalKey<CardImageSliderState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CardImageSlider(
          key: key,
          images: widget.product.image.map((e) => getAttachment(e)).toList(),
          height: 300.0.h,
          stackChild: [
            Positioned(
              top: MediaQuery.of(context).padding.top + 5,
              right: 10.0.w,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColorManager.cardColor,
                ),
                child: BackButton(),
              ),
            ),
          ],
          onChange: () {
            setState(() {});
          },
        ),
        SizedBox(
          height: 80.0.h,
          width: 1.0.sw,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0).r,
            itemCount: widget.product.image.length,
            itemBuilder: (_, i) {
              final item = widget.product.image[i];
              final isCurrent = key.currentState?.currentImage == i;
              return InkWell(
                onTap: () => changAttachment(i),
                splashColor: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isCurrent ? AppColorManager.mainColor : Colors.transparent,
                      width: 2.0.r,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    borderRadius: BorderRadius.circular(12.0.r),
                    color: AppColorManager.cardColor,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: ImageMultiType(
                    url: item,
                    height: 60.0.r,
                    width: 60.0.r,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => 5.0.horizontalSpace,
          ),
        )
      ],
    );
  }
}

class FullscreenImageViewer extends StatefulWidget {
  const FullscreenImageViewer({
    super.key,
    required this.initialIndex,
    required this.attachments,
  });

  final int initialIndex;
  final List<String> attachments;

  @override
  State<FullscreenImageViewer> createState() => _FullscreenImageViewerState();
}

class _FullscreenImageViewerState extends State<FullscreenImageViewer> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  void showNextImage() {
    if (currentIndex < widget.attachments.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void showPreviousImage() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final attachment = widget.attachments[currentIndex];

    return Container(
      height: 350.0.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0).r,
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          InteractiveViewer(
            panEnabled: true,
            scaleEnabled: true,
            child: Center(
              child: ImageMultiType(url: attachment),
            ),
          ),
          // أيقونة الإغلاق
          Positioned(
            top: 0,
            left: 10.0,
            child: IconButton(
              icon: ImageMultiType(
                url: Icons.cancel,
                color: Colors.grey,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
