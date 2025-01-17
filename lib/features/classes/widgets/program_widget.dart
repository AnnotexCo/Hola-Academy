import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

class ProgramWidget extends StatelessWidget {
  const ProgramWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 21.0.w),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                  color: ColorManager.primaryOrangeColor.withValues(alpha: 0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(2, 2),
                  blurStyle: BlurStyle.outer)
            ]),
        height: 94.h,
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
                height: 94.h,
                width: 110.w,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 13.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 2.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Private",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff2D3135),
                    ),
                  ),
                  Row(
                    spacing: 20.w,
                    children: [
                      Text(
                        "Min Age : 3 ",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffBBC0C3),
                        ),
                      ),
                      Text(
                        "Max Age : 60",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffBBC0C3),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Suitable For: All Gender, Baby (0-2)",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffBBC0C3),
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
