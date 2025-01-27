import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/features/home/components/add_baner.dart';
import 'package:hola_academy/features/home/components/evaluation_card.dart';
import 'package:hola_academy/features/home/components/list_of_programs.dart';
import 'package:hola_academy/features/home/components/timeline_widget.dart';
import 'package:hola_academy/features/home/components/welcome_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                EvaluationAppointmentCard(),
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
                ListOfPrograms(
                  title: "Educational",
                ),
                ListOfPrograms(
                  title: "Training",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
