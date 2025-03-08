import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/features/classes/Logic/lessons/cubit/lessons_cubit.dart';
import 'package:hola_academy/features/classes/UI/Loading/programs_loading_screen.dart';
import 'package:hola_academy/features/home/UI/components/add_banner.dart';
import 'package:hola_academy/features/home/UI/components/evaluation_card.dart';
import 'package:hola_academy/features/home/UI/components/list_of_programs.dart';
import 'package:hola_academy/features/home/UI/components/timeline_widget.dart';
import 'package:hola_academy/features/home/UI/components/welcome_header.dart';
import 'package:intl/intl.dart';
import '../../../core/components/calender_widget.dart';
import '../../../core/local_db/save_token.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _userRole;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    String? role = await SaveTokenDB.getRole();
    setState(() {
      _userRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    debugPrint('Building MyWidgetMoom');

    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: SafeArea(
        child: BlocBuilder<LessonsCubit, LessonsState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 18.h,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 13.h,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: WelcomeHeader()),
                    AddBanner(),
                    SizedBox(
                      height: 80.h,
                      width: double.infinity,
                      child: TimelineWidget(),
                    ),
                    if (_userRole == AppString.user ||
                        _userRole == AppString.trainee) ...[
                      context.read<LessonsCubit>().nextLessons != null
                          ? EvaluationAppointmentCard(
                              date: DateFormat('MMM dd').format(context
                                      .read<LessonsCubit>()
                                      .nextLessons
                                      ?.date ??
                                  DateTime.now()),
                              time: context
                                      .read<LessonsCubit>()
                                      .nextLessons
                                      ?.startTime ??
                                  DateTime.now().toString(),
                            )
                          : EvaluationAppointmentCard(
                              date: AppString.thereIsNoAvailableDate,
                              time: AppString.thereIsNoAvailableTime,
                            ),
                    ],
                    // Conditional Rendering Based on Role
                    if (_userRole == AppString.user ||
                        _userRole == AppString.preuser) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Programs",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6C757D),
                          ),
                        ),
                      ),
                      ListOfPrograms(title: "Educational"),
                      ListOfPrograms(title: "Training"),
                    ] else if (_userRole == AppString.trainee) ...[
                      context.read<LessonsCubit>().lessonModel != null
                          ? CalendarWidget(
                              lessons:
                                  context.read<LessonsCubit>().lessonModel ??
                                      [])
                          : ProgramShimmerWidget(),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
