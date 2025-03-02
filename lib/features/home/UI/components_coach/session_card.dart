import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

class SessionReminderCard extends StatelessWidget {
  final String title;
  final String time;

  const SessionReminderCard({
    super.key,
    required this.title,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Image.asset(
            ImageManager.backgroundSession,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Container(
        width: 380.w,
        height: 150.h,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                spacing: 18.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Session Reminder",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffC96852),
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    spacing: 2,
                    children: [
                      Icon(Icons.timer_sharp, color: Colors.white),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Image.asset(
              ImageManager.reminderImageCoach,
              width: 100.w,
              height: 100.h,
            ),
          ],
        ),
      )
    ]);
  }
}
