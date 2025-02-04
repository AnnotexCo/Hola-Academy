import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/color_manager.dart';

class BookedCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String minAge;
  final String maxAge;
  final String suitableFor;
  final String status;

  const BookedCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.minAge,
    required this.maxAge,
    required this.suitableFor,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 398.w,
      height: 93.h,
      //margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      //padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.shadowColor,
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Course Image
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              bottomLeft: Radius.circular(12.r),
            ),
            child: Image.asset(
              imageUrl,
              height: 130.h,
              width: 93.w,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: 22.w),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 9.h),
                Text(
                  "Min Age: $minAge   Max Age: $maxAge",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 7.h),
                Text(
                  "Suitable For: $suitableFor",
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Status Tag
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 6.h, right: 13.w),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 3.5.h, horizontal: 12.5.w),
                  decoration: BoxDecoration(
                    color: ColorManager.lightOrange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorManager.whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
