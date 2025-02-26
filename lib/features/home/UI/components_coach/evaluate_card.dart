import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hola_academy/core/constants/api_constants.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

class EvaluateCard extends StatelessWidget {
  final String backgroundImage;
  final String title;

  const EvaluateCard(
      {super.key, required this.backgroundImage, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18.w),
      child: Container(
        height: 250.h,
        width: 230.w,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.r),
        ),
        child: Stack(
          children: [
            Image.network(ApiConstants.imagesURLApi + backgroundImage,
                height: 250.h, width: 230.w, fit: BoxFit.cover),
            Center(
              child: Text(
                title,
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
      ),
    );
  }
}
