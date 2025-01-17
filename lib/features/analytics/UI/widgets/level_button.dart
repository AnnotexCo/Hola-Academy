import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/color_manager.dart';

Widget buildLevelButton(String text, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isActive ? ColorManager.primaryOrangeColor : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          if (!isActive)
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.grey,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
