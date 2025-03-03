import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/features/classes/Logic/lessons/cubit/lessons_cubit.dart';
import 'package:hola_academy/features/home/UI/components/add_baner.dart';
import 'package:hola_academy/features/home/UI/components/evaluation_card.dart';
import 'package:hola_academy/features/home/UI/components/list_of_programs.dart';
import 'package:hola_academy/features/home/UI/components/timeline_widget.dart';
import 'package:hola_academy/features/home/UI/components/welcome_header.dart';

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

// ----------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: SingleChildScrollView(
            child: Column(
              spacing: 18.h,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 13.h,
                ),
                Align(alignment: Alignment.centerLeft, child: WelcomeHeader()),
                AddBaner(),
                SizedBox(
                  height: 80.h,
                  width: double.infinity,
                  child: TimelineWidget(),
                ),
                if (_userRole == AppString.user ||
                    _userRole == AppString.trainee) ...[
                  BlocBuilder<LessonsCubit, LessonsState>(
                    builder: (context, state) {
                      if (state is NextLessonsSuccess) {
                        return EvaluationAppointmentCard();
                      }
                      return SizedBox.shrink();
                    },
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
                  CalendarWidget(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
