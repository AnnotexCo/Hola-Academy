import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressClassWidget extends StatelessWidget {
  const ProgressClassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                  color: Color(0xCED2D9C9),
                  spreadRadius: 0,
                  blurRadius: 7,
                  blurStyle: BlurStyle.outer)
            ]),
        height: 96.h,
        width: 398.w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 22.w,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  bottomLeft: Radius.circular(12.r)),
              child: Image.asset(
                ImageManager.onBoardingImage2,
                height: double.infinity,
                width: 110.w,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 13.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 7.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Gold Medal Training Plan",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff2D3135),
                    ),
                  ),
                  Text(
                    "Swim With the pros! ",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffBBC0C3),
                    ),
                  ),
                  Row(
                    spacing: 18.w,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      LinearPercentIndicator(
                        padding: EdgeInsets.zero,
                        barRadius: Radius.circular(5.r),
                        progressColor: Color(0xffC96852),
                        animation: true,
                        animationDuration: 1000,
                        width: 100.w, // Use CustomMQ to adapt to screen width
                        lineHeight:
                            7, // Use CustomMQ for responsive line height
                        backgroundColor:
                            const Color.fromARGB(255, 228, 225, 225),
                        percent: (5 / 10),
                        trailing: Text(
                          "  40%",
                          style: TextStyle(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffD58753),
                          ),
                        ),
                      ),
                      Text(
                        "2 Weeks",
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffBBC0C3),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
