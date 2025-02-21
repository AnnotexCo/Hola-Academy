import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

class EvaluateCard extends StatelessWidget {
  final Color? backgroundColor;
  final String? title;
  final Color? vectorColor;

  const EvaluateCard(
      {super.key, this.backgroundColor, this.title, this.vectorColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      width: 230.w,
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorManager.lightOrange,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 70,
            child: ClipRRect(
              child: SvgPicture.asset(
                height: 200.h,
                ImageManager.evaluateBackgroundVector,
                color: vectorColor ?? ColorManager.whiteColor,
              ),
            ),
          ),
          Center(
            child: Text(
              title ?? "Educational",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w400,
                color: ColorManager.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
