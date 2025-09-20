// import 'package:flutter/material.dart';
// import 'package:flutter_date_pickers/flutter_date_pickers.dart';
//
// class CustomStyledDatePicker extends StatefulWidget {
//   @override
//   _CustomStyledDatePickerState createState() => _CustomStyledDatePickerState();
// }
//
// class _CustomStyledDatePickerState extends State<CustomStyledDatePicker> {
//   DateTime _selectedDate = DateTime.now();
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       backgroundColor: Colors.white,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         child: DayPicker.single(
//           selectedDate: _selectedDate,
//           onChanged: (date) {
//             setState(() {
//               _selectedDate = date;
//             });
//           },
//           firstDate: DateTime(2020),
//           lastDate: DateTime(2030),
//           datePickerStyles: DatePickerRangeStyles(
//             selectedSingleDateDecoration: BoxDecoration(
//               color: Colors.deepPurple,
//               shape: BoxShape.circle,
//             ),
//             dayHeaderStyle: DayHeaderStyle(
//               textStyle: TextStyle(color: Colors.grey[700], fontSize: 12),
//             ),
//             displayedPeriodTitle: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
