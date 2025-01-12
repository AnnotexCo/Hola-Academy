
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/color_manager.dart';

class CustomToggleSwitch extends StatelessWidget {
  final bool isEmailSelected;
  final ValueChanged<bool> onToggle;

  const CustomToggleSwitch({
    super.key,
    required this.isEmailSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 291.w,
      height: 45.h,
      decoration: BoxDecoration(
        color: ColorManager.textRedColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onToggle(true),
              child: Container(
                decoration: BoxDecoration(
                  color: isEmailSelected
                      ? ColorManager.textRedColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Email',
                  style: TextStyle(
                    color: isEmailSelected
                        ? Colors.white
                        : ColorManager.textRedColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onToggle(false),
              child: Container(
                decoration: BoxDecoration(
                  color: !isEmailSelected
                      ? ColorManager.textRedColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Phone',
                  style: TextStyle(
                    color: !isEmailSelected
                        ? Colors.white
                        : ColorManager.textRedColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
