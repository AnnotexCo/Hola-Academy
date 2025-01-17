import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/components/custom_app_bar.dart';
import '../../../core/constants/app_string.dart';
import '../../../core/constants/color_manager.dart';

class ScheduleEvaluationScreen extends StatefulWidget {
  const ScheduleEvaluationScreen({super.key});

  @override
  State<ScheduleEvaluationScreen> createState() =>
      _ScheduleEvaluationScreenState();
}

class _ScheduleEvaluationScreenState extends State<ScheduleEvaluationScreen> {
  int selectedDayIndex = 2;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now().add(Duration(days: selectedDayIndex));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Custom Header with back button
          CustomAppBar(
            title: AppString.availableEvaluation,
          ),

          // Custom Header with Days
          Container(
            height: 120.h,
            margin: EdgeInsets.symmetric(vertical: 16.h),
            child: ScrollSnapList(
              itemBuilder: (context, index) {
                bool isSelected = index == selectedDayIndex;
                DateTime date = DateTime.now().add(Duration(days: index));
                double scale = isSelected ? 1.0 : 0.9;
                double rotationAngle =
                    isSelected ? 0 : 0.01; // Slight  for unselected

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDayIndex = index;
                      selectedDate = date;
                    });
                  },
                  child: Transform(
                    transform: Matrix4.identity()
                      ..scale(scale) // Scale effect
                      ..setEntry(3, 2, 0.001) // Perspective
                      ..rotateY(rotationAngle), // 3D rotation effect
                    alignment: Alignment.center,
                    child: DayTile(
                      day: date.day,
                      isSelected: isSelected,
                      weekDay: _getWeekDay(date.weekday),
                    ),
                  ),
                );
              },
              itemCount: 7,
              itemSize: 70.w.toDouble(),
              dynamicItemSize: true, // Adjust size dynamically
              onItemFocus: (index) {
                setState(() {
                  selectedDayIndex = index;
                  selectedDate = DateTime.now().add(Duration(days: index));
                });
              },
              scrollDirection: Axis.horizontal,
              initialIndex: selectedDayIndex.toDouble(),
            ),
          ),
          // Calendar Section
          Expanded(
            child: SfCalendar(
              view: CalendarView.day,
              dataSource: _getCalendarDataSource(selectedDate),
              headerHeight: 0,
              viewHeaderHeight: 0,
              cellBorderColor: Colors.grey.shade300,
              timeSlotViewSettings: TimeSlotViewSettings(
                startHour: 8,
                endHour: 20,
                timeInterval: const Duration(minutes: 60),
                timeFormat: 'h a',
                timeIntervalHeight: 140.h,
                timeTextStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
                timeRulerSize: 60.w,
                dayFormat: 'EEE',
              ),
              appointmentBuilder: (context, calendarAppointmentDetails) {
                return Container(
                  width: 285.84.w,
                  height: 109.1.h,
                  margin: EdgeInsets.only(left: 20.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5BD69),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: 6.w,
                          decoration: const BoxDecoration(
                            color: ColorManager.lightYellow,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Private Session',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Aqua Training',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(
                              'Level A',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 12.sp,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '10 am - 11 am',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getWeekDay(int weekday) {
    List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekDays[weekday - 1];
  }

  _CalendarDataSource _getCalendarDataSource(DateTime selectedDate) {
    List<Appointment> appointments = <Appointment>[
      Appointment(
        startTime: DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          10,
          0,
        ),
        endTime: DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          11,
          0,
        ),
        subject: 'Aqua Training',
        color: const Color(0xFFF5BD69),
      ),
    ];
    return _CalendarDataSource(appointments);
  }
}

class DayTile extends StatelessWidget {
  final int day;
  final bool isSelected;
  final String weekDay;

  const DayTile({
    required this.day,
    required this.isSelected,
    required this.weekDay,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          // Top colored section
          Container(
            height: 8.h,
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFF09C1F)
                  : const Color(0xFFF8D198),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              ),
            ),
          ),
          // Main white card
          Container(
            height: 70.h,
            width: 75.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weekDay,
                  style: TextStyle(
                    color:
                        isSelected ? const Color(0xFFF09C1F) : Colors.black54,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  day.toString(),
                  style: TextStyle(
                    color:
                        isSelected ? const Color(0xFFF09C1F) : Colors.black87,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}

class _CalendarDataSource extends CalendarDataSource {
  _CalendarDataSource(List<Appointment> source) {
    appointments = source;
  }
}
