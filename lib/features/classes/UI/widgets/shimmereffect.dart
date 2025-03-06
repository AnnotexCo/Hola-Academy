import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package

class AvailableClassWidgetShimmer extends StatelessWidget {
  const AvailableClassWidgetShimmer({super.key});

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
          ],
        ),
        height: 96.h,
        width: 398.w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    bottomLeft: Radius.circular(12.r)),
                child: Container(
                  height: double.infinity,
                  width: 110.w,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 13.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 150.w,
                      height: 15.h,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 7.h),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 200.w,
                      height: 12.h,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 7.h),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 80.w,
                      height: 12.h,
                      color: Colors.white,
                    ),
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
