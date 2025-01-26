import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/components/calender_widget.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/home/components/add_baner.dart';

import 'package:hola_academy/features/home/components/timeline_widget.dart';
import 'package:hola_academy/features/home/components/welcome_header.dart';
import 'package:hola_academy/features/home/components_coach/evaluate_card.dart';
import 'package:hola_academy/features/home/components_coach/session_card.dart';
import 'package:hola_academy/features/trainee/widgets/evaluate_dialog.dart';
import 'package:hola_academy/features/trainee/widgets/feedback_dialog.dart';

class HomeScreenCoach extends StatelessWidget {
  const HomeScreenCoach({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0.w),
          child: SingleChildScrollView(
            child: Column(
              spacing: 18.h,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 13.h,
                ),
                Align(alignment: Alignment.centerLeft, child: WelcomeHeader()),
                GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return EvaluateDialog(
                              imageUrl: ImageManager.pic,
                              traineeName: 'Robert Fox',
                              courseTitle: 'Basic Swimming Techniques',
                              onCancel: () {
                                Navigator.of(context).pop();
                              },
                            );
                          });
                    },
                    child: AddBaner()),
                SizedBox(
                  height: 80.h,
                  width: double.infinity,
                  child: TimelineWidget(),
                ),
                SessionReminderCard(
                  title: "You Have a Swimming Level A Session On Monday",
                  time: "5:00 PM",
                ),
                Padding(
                  padding: EdgeInsets.only(left: 18.0.w, top: 0, bottom: 0),
                  child: SizedBox(
                    height: 300.h,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 18.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Evaluate Students",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff6C757D),
                            )),
                        SizedBox(
                          height: 245.h,
                          width: double.infinity,
                          child: ListView(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            children: [
                              EvaluateCard(
                                backgroundColor: Color(0xffF5BD69),
                                title: "Educational",
                                vectorColor: Color(0xffBD5151),
                              ),
                              SizedBox(
                                width: 18.w,
                              ),
                              EvaluateCard(
                                backgroundColor: Color(0xffBD5151),
                                title: "Training",
                                vectorColor: ColorManager.whiteColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CalendarWidget(
                  eventTitle: 'Hi',
                  eventDate: "2025-1-5",
                  eventTime: '5:00 PM',
                ),
                SizedBox(
                  height: 13.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
