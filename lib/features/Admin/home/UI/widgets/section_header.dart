import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/color_manager.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? action;
  final Color? color;
  final void Function()? onPressed;

  const SectionHeader({
    super.key,
    required this.title,
    this.action,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: color ?? ColorManager.darkRedColor,
          ),
        ),
        if (action != null && action!.isNotEmpty)
          TextButton(
            onPressed: onPressed,
            child: Text(
              action!,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: color ?? ColorManager.primaryOrangeColor,
              ),
            ),
          ),
      ],
    );
  }
}
