//
// import 'package:drawable_text/drawable_text.dart';import 'package:victoria/core/strings/enum_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
//
//
// class PdfViewerWidget extends StatelessWidget {
//   const PdfViewerWidget({Key? key, required this.url}) : super(key: key);
//
//   final String url;
//
//   @override
//   Widget build(BuildContext context) {
//     if (url.isEmpty) {
//       return const Center(
//           child: DrawableText(text: 'المعلومات المطلوبة غير متوفرة حاليا'));
//     }
//     return const PDF(
//       swipeHorizontal: true,
//     ).cachedFromUrl(url);
//   }
// }
