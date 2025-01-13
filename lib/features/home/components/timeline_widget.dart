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
  DateTime selectedDate = DateTime(2025, 1, 4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: Column(
        children: [
          EasyDateTimeLine(
            initialDate: DateTime(2025, 1, 1),
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
            // Customizing layout of dayStr and dayNum
            itemBuilder: (context, date, isActive, onTap) {
              final dayStr =
                  EasyConstants.getDayString(date.weekday); // E.g., "Mon"
              final dayNum = date.day.toString(); // E.g., "1"

              return InkWell(
                onTap: onTap,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 4.h),
                  width: 68.w,
                  decoration: isActive
                      ? BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                              BoxShadow(
                                color:
                                    Color(0XFfCED2D9).withValues(alpha: 0.76),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ])
                      : BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                              BoxShadow(
                                blurStyle: BlurStyle.inner,

                                color:
                                    Color(0XFfCED2D9).withValues(alpha: 0.76),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                    Offset(2, 2), // changes position of shadow
                              ),
                            ]),
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
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "";
    }
  }
}
