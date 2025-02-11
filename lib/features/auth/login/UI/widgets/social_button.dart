import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/color_manager.dart';

Widget socialButton(String assetPath, VoidCallback onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.textRedColor),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: SvgPicture.asset(
          assetPath,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
    ),
  );
}
