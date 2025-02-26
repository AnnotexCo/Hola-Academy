import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

Widget bookedShimmerEffect() {
  return ListView.builder(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
    itemCount: 5, 
    itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: double.infinity,
            height: 120.h, 
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
      );
    },
  );
}
