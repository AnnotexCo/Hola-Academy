import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/components/custom_app_bar.dart';
import 'package:hola_academy/core/components/custom_colored_outline_button.dart';
import 'package:hola_academy/features/home/components/program_card.dart';

import '../../core/constants/color_manager.dart';

class DetailClassScreen extends StatelessWidget {
  const DetailClassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 18.h,
          children: [
            CustomAppBar(
              title: "Private",
              widget: CustomColoredOutlineButton(radius: 25, title: 'Book Now', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300, color: ColorManager.primaryOrangeColor), height: 30.h, width: 86.w, onTap: (){
                Navigator.pushNamed(context, Routes.bookProgramsScreen);
              }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0.w),
              child: Column(
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(text: '''Lessons: 12\n         
'''),
                    TextSpan(text: "General Description: \n"),
                    TextSpan(
                        style: TextStyle(fontSize: 14.sp),
                        text:
                            "The Private Program is designed to offer personalized training, focusing on achieving peak performance and preparing participants for high-level competition. It is structured into four progressive levels (A, B, C, D), where participants advance to the next level based on their progress and achievements. Each level builds on the previous one, gradually increasing intensity and refining skills.\n"),
                    TextSpan(text: '''
                      
How the Program Works:\n'''),
                    TextSpan(style: TextStyle(fontSize: 14.sp), text: '''
The training plan spans 12 weeks, with each session lasting between 30 to 60 minutes.
Participants will follow a combination of swimming and dryland workouts, with each session designed to improve endurance, technique, and mental readiness.
As participants progress through the levels, the intensity of the workouts increases to match their development, ensuring continuous improvement.
Each level focuses on mastering different aspects of swimming, and once a participant completes a level, they will move on to the next one for continued growth and performance enhancement.
Note: For detailed explanations of each level (A, B, C, D), please refer to the dedicated page.
Age Range: Suitable for ages 3 to 60. \nGender: The program can be tailored for males, females, or all participants, depending on trainee's needs. 
                        ''')
                  ])),
                  Padding(
                    padding: EdgeInsets.zero,
                    child: SizedBox(
                      height: 300.h,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 18.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Programs Levels",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff9DA3A8),
                                )),
                            SizedBox(
                              height: 240.h,
                              width: double.infinity,
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(right: 18.w),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              Routes.programlevlScreen);
                                        },
                                        child: ProgramCard(
                                          backgroundColor: Color(0xffF7E9E9),
                                          text: "Level A",
                                          height: 240.h,
                                          width: 196.w,
                                          color: Color(0xffAD2525),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
