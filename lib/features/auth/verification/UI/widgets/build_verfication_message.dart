  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_string.dart';
import '../../../../../core/constants/color_manager.dart';

Widget buildVerificationMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppString.verification,
          style: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.w600,
            color: ColorManager.textRedColor,
          ),
        ),
        SizedBox(height: 25.h),
        Text(
          AppString.sentVerificationCode,
          style: TextStyle(
            fontSize: 16.sp,
            color: ColorManager.textRedColor,
          ),
        ),
        Text(
          '+20 *** **** ***',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: ColorManager.textRedColor,
          ),
        ),
      ],
    );
  }
