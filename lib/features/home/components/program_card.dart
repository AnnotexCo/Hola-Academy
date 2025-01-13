import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgramCard extends StatelessWidget {
  const ProgramCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 176.h,
          width: 174.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22.r),
          ),
          child:
              Image.asset("assets/images/programimage.png", fit: BoxFit.fill),
        ),
        Positioned(
            top: 8.h,
            right: 35.w,
            left: 35.w,
            child: Container(
              width: 104.w,
              height: 25.h,
              decoration: BoxDecoration(
                color: Color(0xfef5e9cc).withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  "Beginner",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffF09C1F),
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
