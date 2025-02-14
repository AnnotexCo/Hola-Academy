import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProgramShimmerWidget extends StatelessWidget {
  const ProgramShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Color(0xCED2D9C9),
                spreadRadius: 0,
                blurRadius: 7,
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          height: 96.h,
          width: 398.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 22.w,
            children: [
              Container(
                width: 110.w,
                height: double.infinity,
                color: Colors.white, // Placeholder for the image
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 13.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 2.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100.w,
                      height: 14.h,
                      color: Colors.white, // Placeholder for the text
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      spacing: 20.w,
                      children: [
                        Container(
                          width: 60.w,
                          height: 12.h,
                          color: Colors.white, 
                        ),
                        Container(
                          width: 60.w,
                          height: 12.h,
                          color: Colors.white, 
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: 150.w,
                      height: 10.h,
                      color: Colors.white, 
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}