import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/color_manager.dart';

class CustomListView extends StatelessWidget {
  final List<Map<String, String>> data; // List of trainee data
  final double itemHeight;
  final Color backgroundColor;
  final Color borderColor;
  final String profileImagePath;

  const CustomListView({
    super.key,
    required this.data,
    this.itemHeight = 74.0,
    this.backgroundColor = const Color(0xFFFFF4F4),
    this.borderColor = const Color(0xFFD32F2F),
    this.profileImagePath = 'assets/images/profilepic.png',
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final trainee = data[index];
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 9.h,
          ),
          child: Container(
            width: double.infinity,
            height: itemHeight.h,
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: borderColor,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.asset(
                    profileImagePath,
                    width: 50.w,
                    height: 50.h,
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: 'Name: ',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.textRedColor,
                          ),
                          children: [
                            TextSpan(
                              text: trainee['name'] ?? '',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: ColorManager.graycolorHeadline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: 'Phone Number: ',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.textRedColor,
                          ),
                          children: [
                            TextSpan(
                              text: trainee['phone'] ?? '',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: ColorManager.graycolorHeadline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
