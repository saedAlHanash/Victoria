// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_multi_type/image_multi_type.dart';
//
// import '../../../../core/util/my_style.dart';
// import '../../../../generated/assets.dart';
// import '../../../../services/location_service/my_location_cubit/my_location_cubit.dart';
//
// class MyLocationWidget extends StatefulWidget {
//   const MyLocationWidget(
//       {super.key, required this.onDone});
//
//
//   final Function(LocationServiceInitial state) onDone;
//
//   @override
//   State<MyLocationWidget> createState() => _MyLocationWidgetState();
// }
//
// class _MyLocationWidgetState extends State<MyLocationWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 20.0.r,
//       width: 20.0.r,
//       child: BlocConsumer<LocationServiceCubit, LocationServiceInitial>(
//         listenWhen: (p, c) => c.done,
//         listener: (context, state) => widget.onDone.call(state),
//         builder: (context, state) {
//           if (state.loading) {
//             return MyStyle.loadingWidget();
//           }
//           return IconButton(
//             icon: const ImageMultiType(url: Assets.iconsLocater),
//             onPressed: () =>
//                 context.read<LocationServiceCubit>().getMyLocation(),
//           );
//         },
//       ),
//     );
//   }
// }
