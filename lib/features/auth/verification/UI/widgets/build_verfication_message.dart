import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/color_manager.dart';

Widget buildTextMessage(
  String? title,
  String? description,
  String? subTitle,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      if (title != null && title.isNotEmpty) 
        Text(
          title,
          style: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.w600,
            color: ColorManager.textRedColor,
          ),
        ),
      if (title != null && title.isNotEmpty) SizedBox(height: 25.h), 

      if (description != null && description.isNotEmpty) 
        Text(
          description,
          style: TextStyle(
            fontSize: 16.sp,
            color: ColorManager.textRedColor,
          ),
        ),

      if (subTitle != null && subTitle.isNotEmpty) 
        Text(
          subTitle,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: ColorManager.textRedColor,
          ),
        ),
    ],
  );
}
