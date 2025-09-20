// import 'package:victoria/features/educational_grade/bloc/educational_grade_cubit/educational_grade_cubit.dart';
// import 'package:victoria/features/educational_grade/bloc/eductaionl_section_cupit/educational_section_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_multi_type/image_multi_type.dart';
//
// import '../../../../../core/widgets/app_bar/app_bar_widget.dart';
// import '../../../../../router/app_router.dart';
// import '../../../educational_grade/data/response/grad.dart';
// import '../../data/request/signup_request.dart';
//
//
// class ChooseSecSign extends StatefulWidget {
//   const ChooseSecSign({super.key, required this.request});
//   final SignupRequest request;
//   @override
//   State<ChooseSecSign> createState() => _ChooseSecSignState();
// }
//
// class _ChooseSecSignState extends State<ChooseSecSign> {
//   @override
//   Widget build(BuildContext context) {
//     // final args = ModalRoute.of(context)!.settings.arguments;
//     // print('Arguments passed: $args');  // Log the arguments to check if they are passed correctly
//     // final signupRequest = args as SignupRequest?;
//     // print('signupRequest: $signupRequest');  // Log the signupRequest to check if it is passed correctly
//     return Scaffold(
//
//         backgroundColor: Colors.white,
//         appBar:  AppBarWidget(
//           color: Colors.white,
//           //widget.request.name
//           title: Text("  الاقسام",
//             style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold
//             ),
//           ),
//           leading: InkWell(
//               onTap: (){
//                 Navigator.pop(context);
//               },
//               child: Icon(Icons.arrow_back_ios_sharp,color: Colors.black,)),
//         ),
//         body:BlocBuilder<SectionsCubit,SectionsInitial>(builder: (context,state){
//           return Padding(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: 10,
//                 vertical: 15
//             ),
//             child: ListView.separated(
//                 shrinkWrap: true,
//                 itemBuilder: (context,index){
//                   return
//                     InkWell(
//                       onTap: () async {
//                         if (context.read<EducationalGradeCubit>().state.loading) {
//                           showDialog(
//                             context: context,
//                             builder: (context) => CircularProgressIndicator(),
//                           );
//                         } else {
//                           await context.read<EducationalGradeCubit>().getData(
//                               request: GradeId(section_id: state.result[index].id)
//                           );
//                           Navigator.pushNamed(context, RouteName.customSign,
//                           arguments: widget.request
//                           );
//                         }
//                       },
//                       child:
//                       Container(
//                         height: 150,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12), // Rounded corners
//
//                         ),
//                         clipBehavior: Clip.antiAlias, // Ensures content respects the border radius
//                         child: ImageMultiType(
//                           url: state.result[index].image,
//                           height: 150,
//                           fit: BoxFit.cover,
//                         ),
//                       )
//                      /* Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(10),
//                               topLeft: Radius.circular(10),
//                               bottomRight: Radius.circular(10),
//                             ),
//                             image: DecorationImage(
//                               image: AssetImage(Assets.imagesSh,
//                               ),
//
//                               // Asset image for decoration
//                               fit: BoxFit.cover, // Ensures the image covers the entire container area
//                             )),
//                         child:
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 10,
//                               horizontal: 10
//                           ),
//                           child: Row(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     ImageMultiType(
//                                       url: state.result[index].image,
//                                       width: 50,
//                                       height: 50,
//
//                                     ),
//                                     Text(
//                                       state.result[index].name,
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: 90,),
//                               ImageMultiType(
//                                 url: Assets.imagesBs,
//                                   width: 100,
//                                    height: 110,
//
//                               ),
//                               // Image.asset(
//                               //   Assets.imagesBs,
//                               //   fit:BoxFit.cover,
//                               //   width: 100,
//                               //   height: 110,
//                               // ),
//                             ],
//                           ),
//                         ),
//                       ),*/
//                     );
//                   // ClipPath(child: Container(
//                   //   width: 300,
//                   //   height: 60,
//                   //   decoration: BoxDecoration(
//                   //       color: Color(0xFF2C2C7C), // اللون الخلفي
//                   //       borderRadius: BorderRadius.circular(20)
//                   //   ),
//                   //   child: Padding(
//                   //     padding: const EdgeInsets.all(16.0),
//                   //     child: Stack(
//                   //       children: [
//                   //
//                   //         Align(
//                   //           alignment: Alignment.centerRight,
//                   //           child: Column(
//                   //             mainAxisSize: MainAxisSize.min,
//                   //             crossAxisAlignment: CrossAxisAlignment.end,
//                   //             children: [
//                   //
//                   //               Text(
//                   //           state.result[index].name,
//                   //                 style: TextStyle(
//                   //                   color: Colors.white,
//                   //                   fontSize: 14,
//                   //                 ),
//                   //               ),
//                   //             ],
//                   //           ),
//                   //         ),
//                   //
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ));
//                 },
//                 separatorBuilder: (context,state){
//                   return SizedBox(height: 15,);
//                 },
//                 itemCount: state.result.length),
//           );
//         })
//     );
//   }
// }
