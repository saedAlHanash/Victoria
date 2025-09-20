// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../core/widgets/card_slider_widget.dart';
// import '../../../ads/bloc/banners_cubit/banners_cubit.dart';
//
//
// class HomeSliderWidget extends StatelessWidget {
//   const HomeSliderWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 260.0.h,
//       width: 1.0.sw,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           BlocBuilder<BannersCubit, BannersInitial>(
//             builder: (context, state) {
//               return Container(
//                 height: 240.0.h,
//                 clipBehavior: Clip.hardEdge,
//                 margin: EdgeInsets.all(16.0).r,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15.0.r),
//                 ),
//                 child: CardSlider(
//                   height: 1.0.sh,
//                   width: 1.0.sw,
//                   images: state.result.map((e) => e.image).toList(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
