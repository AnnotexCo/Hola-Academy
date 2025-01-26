import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  final String eventTitle;
  final String eventDate;
  final String eventTime;

  const CalendarWidget({
    super.key,
    required this.eventTitle,
    required this.eventDate,
    required this.eventTime,
  });

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 298.h,
          width: 320.w,
          decoration: BoxDecoration(
              color: ColorManager.backgroundColor,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    blurStyle: BlurStyle.outer,
                    offset: Offset(0, 2))
              ]),
          child: TableCalendar(
            rowHeight: 40.h,
            calendarFormat: CalendarFormat.month,
            daysOfWeekHeight: 30,
            daysOfWeekVisible: true,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            daysOfWeekStyle: DaysOfWeekStyle(
                decoration: BoxDecoration(
                  color: ColorManager.backgroundColor,
                ),
                weekendStyle:
                    TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
                weekdayStyle:
                    TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400)),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              tablePadding: EdgeInsets.symmetric(horizontal: 20.w),
              cellPadding: EdgeInsets.only(top: 8),
              cellAlignment: Alignment.topCenter,
              rowDecoration: BoxDecoration(
                color: ColorManager.backgroundColor,
              ),
              cellMargin: EdgeInsets.zero,
              weekNumberTextStyle:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              rangeStartTextStyle:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              rangeEndTextStyle:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              disabledTextStyle:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              holidayTextStyle:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              weekendTextStyle:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              outsideTextStyle:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              withinRangeTextStyle:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              todayTextStyle:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              selectedTextStyle:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              defaultTextStyle:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
            ),
            headerStyle: HeaderStyle(
              formatButtonShowsNext: false,
              headerMargin: EdgeInsets.symmetric(horizontal: 20.w),
              headerPadding: EdgeInsets.zero,
              rightChevronIcon: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color(0xffFE7700),
                size: 15.sp,
              ),
              leftChevronIcon: Icon(
                size: 15.sp,
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xffFE7700),
              ),
              formatButtonVisible: false,
              titleCentered: true,
              formatButtonPadding: EdgeInsets.all(2.sp),
              formatButtonDecoration: BoxDecoration(
                color: Color(0xffADD8E6),
                borderRadius: BorderRadius.circular(3.r),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              titleTextStyle:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
              formatButtonTextStyle: TextStyle(
                  backgroundColor: Color(0xffADD8E6),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff434050)),
            ),
          ),
        ),
      ],
    );
  }
}
