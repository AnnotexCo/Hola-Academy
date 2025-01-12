  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/color_manager.dart';

Widget socialButton(IconData icon) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.textRedColor),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 20.sp,
        color: ColorManager.primaryOrangeColor,
      ),
    );
  }
