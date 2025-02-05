import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/components/calender_widget.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/home/components/add_baner.dart';

import 'package:hola_academy/features/home/components/timeline_widget.dart';
import 'package:hola_academy/features/home/components/welcome_header.dart';
import 'package:hola_academy/features/home/components_coach/classes_dialog.dart';
import 'package:hola_academy/features/home/components_coach/evaluate_card.dart';
import 'package:hola_academy/features/home/components_coach/session_card.dart';
import 'package:hola_academy/features/trainee/widgets/evaluate_dialog.dart';

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
                SizedBox(
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
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return ClassesDialog(
                                      title: "Educational",
                                      onCancel: () => Navigator.pop(context),
                                      options: [
                                        {
                                          "title": "Private",
                                          "icon": ImageManager.privateclass
                                        },
                                        {
                                          "title": "SemiPrivate",
                                          "icon": ImageManager.semiprivateclass
                                        },
                                        {
                                          "title": "Aqua",
                                          "icon": ImageManager.aquaclass
                                        },
                                        {
                                          "title": "Kids",
                                          "icon": ImageManager.kidsclass
                                        },
                                      ],
                                      onOptionSelected: (selected) {
                                        if (selected == "Private") {
                                          showPrivateLevelsDialog(context);
                                        }
                                      },
                                    );
                                  },
                                );
                              },
                              child: EvaluateCard(
                                backgroundColor: Color(0xffF5BD69),
                                title: "Educational",
                                vectorColor: Color(0xffBD5151),
                              ),
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
                CalendarWidget(),
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

void showPrivateLevelsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return ClassesDialog(
        title: "Private Levels",
        onCancel: () => Navigator.pop(context),
        options: [
          {"title": "Level A", "icon": ImageManager.privateclass},
          {"title": "Level B", "icon": ImageManager.semiprivateclass},
          {"title": "Level C", "icon": ImageManager.kidsclass},
          {"title": "Level D", "icon": ImageManager.aquaclass},
        ],
        onOptionSelected: (selectedLevel) {
          if (selectedLevel == "Level A") {
            showClassifcationDialog(context, selectedLevel);
          }
        },
      );
    },
  );
}

void showClassifcationDialog(BuildContext context, String levl) {
  showDialog(
    context: context,
    builder: (_) {
      return ClassesDialog(
        title: levl,
        onCancel: () => Navigator.pop(context),
        options: [
          {
            "title": "Beginner Swimming Class",
            "icon": ImageManager.privateclass
          },
          {
            "title": "Intermediate Swimming Class",
            "icon": ImageManager.semiprivateclass
          },
          {"title": "Aqua Fitness Class", "icon": ImageManager.aquaclass},
          {
            "title": "Open Water Swimming Class",
            "icon": ImageManager.semiprivateclass
          },
          {"title": "Kids Swimming Class", "icon": ImageManager.kidsclass},
        ],
        onOptionSelected: (selectedLevel) {
          if (selectedLevel == "Beginner Swimming Class") {
            Navigator.pushNamed(context, Routes.findTraineeScreen);
          }
        },
      );
    },
  );
}
