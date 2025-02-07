import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  CalendarWidgetState createState() => CalendarWidgetState();
}

class CalendarWidgetState extends State<CalendarWidget> {
  final DateTime _focusedDay = DateTime(2025, 1, 1);
  DateTime? _selectedDay;

  final Set<DateTime> pastLessons = {
    DateTime.utc(2025, 2, 1),
    DateTime.utc(2025, 2, 5),
    DateTime.utc(2025, 2, 10),
    DateTime.utc(2025, 2, 15),
  };

  final Set<DateTime> upcomingLessons = {
    DateTime.utc(2025, 2, 17),
    DateTime.utc(2025, 2, 19),
    DateTime.utc(2025, 2, 24),
    DateTime.utc(2025, 2, 26),
  };

  final Set<DateTime> missedLessons = {
    DateTime.utc(2025, 1, 29),
    DateTime.utc(2025, 2, 3),
    DateTime.utc(2025, 2, 14),
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 320.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues( alpha :0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TableCalendar(
            availableGestures: AvailableGestures.horizontalSwipe,
            firstDay: DateTime.utc(2025, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.month,
            daysOfWeekHeight: 30,
            daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff7E818C)),
                weekendStyle:
                    TextStyle(fontSize: 12.sp, color: Color(0xff7E818C))),
            rowHeight: 40.h,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, date, _) {
                if (_containsDate(pastLessons, date)) {
                  return _buildLessonMarker(date, Color(0xffE0A89C));
                } else if (_containsDate(upcomingLessons, date)) {
                  return _buildLessonMarker(date, Color(0xffBB4227));
                } else if (_containsDate(missedLessons, date)) {
                  return _buildMissedLessonMarker(date);
                }
                return null;
              },
            ),
            calendarStyle: CalendarStyle(
              todayTextStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
              todayDecoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(fontSize: 14.sp),
              selectedDecoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              tableBorder: TableBorder(borderRadius: BorderRadius.circular(50)),
              outsideDaysVisible: true,
              outsideTextStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
              defaultTextStyle: TextStyle(fontSize: 14.sp),
            ),
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              rightChevronIcon: Icon(Icons.arrow_forward_ios_outlined,
                  size: 15.sp, color: Colors.orange),
              leftChevronIcon: Icon(Icons.arrow_back_ios_new_rounded,
                  size: 15.sp, color: Colors.orange),
              titleTextStyle:
                  TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Align(alignment: Alignment.centerLeft, child: _buildLegend()),
      ],
    );
  }

  bool _containsDate(Set<DateTime> dates, DateTime date) {
    return dates.any((d) => isSameDay(d, date));
  }

  Widget _buildLessonMarker(DateTime date, Color color) {
    return Center(
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '${date.day}',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp),
          ),
        ),
      ),
    );
  }

  Widget _buildMissedLessonMarker(DateTime date) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildLessonMarker(date, Color(0xffB96024)),
          Icon(Icons.close, color: Colors.white, size: 26.sp),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(Color(0xffE0A89C), "Past Lessons"),
        SizedBox(width: 20.w),
        _buildLegendItem(Color(0xffBB4227), "Upcoming Lessons"),
        SizedBox(width: 30.w),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label, {IconData? icon}) {
    return Row(
      children: [
        Container(
          width: 18.w,
          height: 18.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child:
              icon != null ? Icon(icon, color: Colors.white, size: 12) : null,
        ),
        SizedBox(width: 4.w),
        Text(label,
            style: TextStyle(
                fontSize: 14.sp,
                color: Color(0xff9DA3A8),
                fontWeight: FontWeight.w400)),
      ],
    );
  }
}
