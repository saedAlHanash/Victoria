import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:victoria/core/widgets/my_button.dart';

class DoneCreateOrderPage extends StatelessWidget {
  const DoneCreateOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          0.0.verticalSpace,
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0).r,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [],
              ),
            ),
          ),
          MyButton(
            text: 'تم',
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
