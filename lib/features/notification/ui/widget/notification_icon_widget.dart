import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../bloc/notification_count_cubit/notification_count_cubit.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCountCubit, NotificationCountInitial>(
      builder: (context, state) {
        return Stack(
          children: [
            ImageMultiType(
              url: Icons.notifications,
              color: Colors.grey,
              height: 25.0.r,
            ),
            if (state.haveNotifications)
              Container(
                height: 8.0.r,
                width: 8.0.r,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
              )
          ],
        );
      },
    );
  }
}
