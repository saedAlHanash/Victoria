// import 'package:victoria/generated/assets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../../core/widgets/app_bar/app_bar_widget.dart';
// import '../../../../../core/widgets/refresh_widget/refresh_widget.dart';
// import '../../../../../router/app_router.dart';
// import '../../../educational_grade/bloc/educational_grade_cubit/educational_grade_cubit.dart';
// import '../../bloc/signup_cubit/signup_cubit.dart';
// import '../../data/request/signup_request.dart';
//
// class CustomCardWithCurveSign extends StatefulWidget {
//   const CustomCardWithCurveSign({super.key, required this.request});
//   final SignupRequest request;
//   @override
//   State<CustomCardWithCurveSign> createState() => _CustomCardWithCurveSignState();
// }
//
// class _CustomCardWithCurveSignState extends State<CustomCardWithCurveSign> {
//   SignupCubit get signupCubit => context.read<SignupCubit>();
//
//   SignupInitial get signupState => context.read<SignupCubit>().state;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBarWidget(
//           color: Colors.white,
//           title: Text(
//             "المراحل",
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           leading: InkWell(
//               onTap: () {
//                 context.read<EducationalGradeCubit>().getData(newData: true);
//                 Navigator.pop(context);
//               },
//               child: Icon(
//                 Icons.arrow_back_ios_sharp,
//                 color: Colors.black,
//               )),
//         ),
//         body:
//             BlocBuilder<EducationalGradeCubit, EducationalGradeInitial>(builder: (context, state) {
//           return RefreshWidget(
//             isLoading: state.loading,
//             onRefresh: () => context.read<EducationalGradeCubit>().getData(newData: true),
//             child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
//                 child: ListView.separated(
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       return InkWell(
//                         onTap: () {
//                           final selectedId = state.result[index].id;
//                           // print('Selected ID: $selectedId');
//                           // final name = widget.request.name;
//                           // final phone = widget.request.phone;
//                           // final gender = widget.request.gender;
//                           // final birth_date = widget.request.birthday;
//                           // print('name: $name');
//                           // print('name: ${signupCubit.setName= widget.request.name}');
//                           // print('phone: ${signupCubit.setPhone= widget.request.phone}');
//                           // print('gender: ${signupCubit.setGender= widget.request.gender}');
//                           // print('name: ${signupCubit.setBirthday= widget.request.birthday}');
//                           // print('name: ${signupCubit.setPassword= widget.request.password}');
//                           signupCubit.setName = widget.request.name;
//                           signupCubit.setPhone = widget.request.phone;
//                           signupCubit.setGender = widget.request.gender;
//                           signupCubit.setBirthday = widget.request.birthday;
//                           signupCubit.setPassword = widget.request.password;
//                           signupCubit.setEducationalGrade = selectedId;
//                           // signupCubit.setLocation(
//                           //   location: widget.request.location,
//                           //   locationName: widget.request.locationName,
//                           // );
//                           signupCubit.setEducationalGrade = selectedId;
//                           signupCubit.signup();
//                           Navigator.pushNamedAndRemoveUntil(
//                               context, RouteName.confirmCode, (route) => false);
//                                                 },
//
//                         // onTap: (){
//                         //
//                         //   state.getSpinnerItems(
//                         //      selectedId: state.result[index].id,
//                         //   );
//                         //   signupCubit.signup();
//                         //   signupState.request.name.toString();
//                         //   print('state.result[index].id: ${ signupState.request.name.toString()}');
//                         //
//                         //
//                         // },
//                         child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                 topRight: Radius.circular(10),
//                                 topLeft: Radius.circular(10),
//                                 bottomRight: Radius.circular(10),
//                               ),
//                               image: DecorationImage(
//                                 image: AssetImage(
//                                   Assets. /*iconsShape2*/ imagesChose,
//                                 ),
//
//                                 // Asset image for decoration
//                                 fit: BoxFit
//                                     .cover, // Ensures the image covers the entire container area
//                               )),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//                             child: Row(
//                               children: [
//                                 SizedBox(
//                                   width: 15,
//                                 ),
//                                 Container(
//                                   height: 22,
//                                   width: 2,
//                                   color: Color(0xffD9E8FB),
//                                 ),
//                                 SizedBox(
//                                   width: 15,
//                                 ),
//                                 Text(
//                                   state.result[index].name,
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//
//                       // ClipPath(child: Container(
//                       //   width: 300,
//                       //   height: 60,
//                       //   decoration: BoxDecoration(
//                       //       color: Color(0xFF2C2C7C), // اللون الخلفي
//                       //       borderRadius: BorderRadius.circular(20)
//                       //   ),
//                       //   child: Padding(
//                       //     padding: const EdgeInsets.all(16.0),
//                       //     child: Stack(
//                       //       children: [
//                       //
//                       //         Align(
//                       //           alignment: Alignment.centerRight,
//                       //           child: Column(
//                       //             mainAxisSize: MainAxisSize.min,
//                       //             crossAxisAlignment: CrossAxisAlignment.end,
//                       //             children: [
//                       //
//                       //               Text(
//                       //           state.result[index].name,
//                       //                 style: TextStyle(
//                       //                   color: Colors.white,
//                       //                   fontSize: 14,
//                       //                 ),
//                       //               ),
//                       //             ],
//                       //           ),
//                       //         ),
//                       //
//                       //       ],
//                       //     ),
//                       //   ),
//                       // ));
//                     },
//                     separatorBuilder: (context, state) {
//                       return SizedBox(
//                         height: 15,
//                       );
//                     },
//                     itemCount: state.result.length)),
//           );
//         }));
//   }
// }
//
// class CustomCardClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     final controlPoint1 = Offset(size.width * 0.8, size.height * 0.6);
//     final controlPoint2 = Offset(size.width * 0.8, size.height * 0.8);
//
//     path.lineTo(0, size.height); // Start from the bottom-left corner
//     path.quadraticBezierTo(
//       controlPoint1.dx,
//       controlPoint1.dy,
//       controlPoint2.dx,
//       controlPoint2.dy,
//     );
//     path.lineTo(size.width, 0); // Straight line to the top-right corner
//     path.lineTo(0, 0); // Close the path
//     path.close();
//
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
// // void main() {
// //   runApp(MaterialApp(
// //     home: CustomCardWithCurve(),
// //   ));
// // }
