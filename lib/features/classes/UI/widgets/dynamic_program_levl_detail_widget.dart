import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

import '../../Data/Model/programs_model.dart';

class ProgramLevlDetailWidget extends StatelessWidget {
   final LevelModel level;
  const ProgramLevlDetailWidget({super.key, required this.level});

  @override

  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 392.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurStyle: BlurStyle.outer,
                  blurRadius: 2,
                  spreadRadius: 0,
                  offset: Offset(0, 1))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r)),
              child: Image.asset(
                ImageManager.onBoardingImage3,
                height: 170.h,
                width: 393.w,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // "Level A",
                    level.name,
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff2D3135)),
                  ),
                  Text(
                    // "\$10",
                    "\$${level.price}",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffBB4227)),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 60, 65, 70)),
                    text: '''Classes: 8\n         
'''),
                TextSpan(
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff626A72)),
                    text: '''Lessons: ${level.lessonNumber}\n         
'''),
                TextSpan(
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 60, 65, 70)),
                    text: "General Description: \n"),
                TextSpan(
                    style: TextStyle(fontSize: 14.sp),
                    text:
                        level.clarification,
                ),
                        // "The Private Program is designed to offer personalized training, focusing on achieving peak performance and preparing participants for high-level competition. It is structured into four progressive levels (A, B, C, D), where participants advance to the next level based on their progress and achievements. Each level builds on the previous one, gradually increasing intensity and refining skills.\n"),
                TextSpan(
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 60, 65, 70)),
                    text: level.description),
//                     '''
                        
// How the Program Works:\n'''),
//                 TextSpan(style: TextStyle(fontSize: 14.sp), text: '''
// The training plan spans 12 weeks, with each session lasting between 30 to 60 minutes.
// Participants will follow a combination of swimming and dryland workouts, with each session designed to improve endurance, technique, and mental readiness.
// As participants progress through the levels, the intensity of the workouts increases to match their development, ensuring continuous improvement.
// Each level focuses on mastering different aspects of swimming, and once a participant completes a level, they will move on to the next one for continued growth and performance enhancement.
// Note: For detailed explanations of each level (A, B, C, D), please refer to the dedicated page.
// Age Range: Suitable for ages 3 to 60. \nGender: The program can be tailored for males, females, or all participants, depending on trainee's needs. 
//             ''')
              ])),
            ),
          ],
        ),
      ),
    );
  }
}
