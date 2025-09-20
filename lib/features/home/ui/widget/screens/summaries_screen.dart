// import 'package:victoria/core/strings/app_color_manager.dart';
// import 'package:image_multi_type/image_multi_type.dart';
// import 'package:drawable_text/drawable_text.dart';import 'package:victoria/core/strings/enum_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../core/strings/enum_manager.dart';
// import '../../../../../core/util/my_style.dart';
// import '../../../../../core/widgets/not_found_widget.dart';
// import '../../../../../router/app_router.dart';
//
//
// class SummariesScreen extends StatelessWidget {
//   const SummariesScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AllSummariesCubit, AllSummariesInitial>(
//       builder: (context, state) {
//         if (state.statuses .loading) {
//           return MyStyle.loadingWidget();
//         }
//
//         final list = state.result.data;
//         if (list.isEmpty) {
//           return const NotFoundWidget(
//             text: 'لا توجد أي ملازم',
//           );
//         }
//
//         return GridView.builder(
//           shrinkWrap: true,
//           itemCount: list.length,
//           padding:
//               const EdgeInsets.only(top: 20.0, bottom: 100.0, left: 25.0, right: 25.0).r,
//           itemBuilder: (_, i) {
//             return InkWell(
//               onTap: () {
//                 Navigator.pushNamed(
//                   context,
//                   RouteName.summaryPdf,
//                   arguments: list[i],
//                 );
//               },
//               child: ItemSummaries(item: list[i]),
//             );
//           },
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 10.0.h,
//             crossAxisSpacing: 10.0.w,
//             mainAxisExtent: 240.0.h,
//           ),
//         );
//       },
//     );
//   }
// }
//
// class ItemSummaries extends StatelessWidget {
//   const ItemSummaries({Key? key, required this.item}) : super(key: key);
//   final Summary item;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 190.0.h,
//           width: 1.0.sw,
//           clipBehavior: Clip.hardEdge,
//           margin: const EdgeInsets.symmetric(horizontal: 6.0).w,
//           decoration: BoxDecoration(
//             border: Border.all(color: AppColorManager.lightGray),
//             borderRadius: BorderRadius.circular(4.0.r),
//           ),
//           child: Stack(
//             children: [
//               ImageMultiType(
//                 url: item.photo.url,
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   height: 50.0.h,
//                   width: 1.0.sw,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.vertical(
//                       bottom: Radius.circular(4.0.r),
//                     ),
//                     gradient: const LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.black12,
//                         Colors.black26,
//                         Colors.black38,
//                       ],
//                     ),
//                   ),
//                   alignment: Alignment.center,
//                   child: DrawableText(
//                     text: item.name,
//                     maxLines: 2,
//                     color: Colors.white,
//                     size: 12.0.sp,
//                     padding: const EdgeInsets.symmetric(vertical: 5.0).h,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
