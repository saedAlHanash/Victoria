// import 'package:drawable_text/drawable_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'package:image_multi_type/image_multi_type.dart';
//
// import '../../../../core/app/app_provider.dart';
// import '../../../../core/util/my_style.dart';
// import '../../../../generated/assets.dart';
// import '../../../../generated/l10n.dart';
// import '../../../../services/app_info_service.dart';
// import '../pages/home_screen.dart';
// import '../widget/hi_widget.dart';
//
// class HomeDrawer extends StatelessWidget {
//   const HomeDrawer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: Colors.white,
//       child: Column(
//         children: [
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.all(8.0),
//               children: [
//                 HiWidgetStudent(showSchoolName: false),
//                 Divider(),
//                 ItemMenu(
//                   onTap: () {
//                     context.pushReplacementNamed(RouteName.studentRecords);
//                   },
//                   name: S.of(context).changeStudent,
//                   image: Assets.iconsSwap,
//                 ),
//                 ItemMenu(
//                   onTap: () {
//                     context.pushNamed(RouteName.examsSchedule);
//                   },
//                   name: S.of(context).examSchedule,
//                   image: Assets.iconsCalender,
//                 ),
//                 ItemMenu(
//                   onTap: () {},
//                   name: S.of(context).weekSchedule,
//                   image: Assets.iconsSchoolBag,
//                 ),
//                 ItemMenu(
//                   onTap: () {},
//                   name: S.of(context).scoreCard,
//                   image: Assets.iconsOpenBook,
//                 ),
//                 Divider(),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               children: [
//                 MyButton(
//                   onTap: () {
//                     AppProvider.logout(withDialog: true);
//                   },
//                   text: S.of(context).logout,
//                 ),
//                 20.0.verticalSpace,
//                 DrawableText(text: '${S.of(context).buildnumber}: ${AppInfoService.appInfo.buildNumber}'),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
