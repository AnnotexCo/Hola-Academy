import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/color_manager.dart';

class TimelineWidget extends StatefulWidget {
  const TimelineWidget({super.key});

  @override
  State<TimelineWidget> createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
  DateTime selectedDate = DateTime.now(); // Set default selected date to today

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: Column(
        children: [
          EasyDateTimeLine(
            initialDate: DateTime.now(), // Start from today's date
            onDateChange: (newDate) {
              setState(() {
                selectedDate = newDate;
              });
            },
            headerProps: EasyHeaderProps(
              showHeader: false, // Hide the dropdown and header
            ),
            dayProps: EasyDayProps(
              width: 68.w,
              height: 76.h,
            ),
            itemBuilder: (context, date, isActive, onTap) {
              final dayStr = EasyConstants.getDayString(date.weekday);
              final dayNum = date.day.toString();

              return InkWell(
                onTap: onTap,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 4.h),
                  width: 68.w,
                  decoration: isActive
                      ? BoxDecoration(
                          color: ColorManager.primaryOrangeColor,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFCED2D9).withValues(alpha: 0.76),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        )
                      : BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              blurStyle: BlurStyle.inner,
                              color: const Color(0xFFCED2D9).withValues(alpha: 0.76),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dayNum,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: isActive ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        dayStr,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: isActive ? Colors.white : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class EasyConstants {
  static String getDayString(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return "Mon";
      case DateTime.tuesday:
        return "Tue";
      case DateTime.wednesday:
        return "Wed";
      case DateTime.thursday:
        return "Thu";
      case DateTime.friday:
        return "Fri";
      case DateTime.saturday:
        return "Sat";
      case DateTime.sunday:
        return "Sun";
      default:
        return "";
    }
  }
}
