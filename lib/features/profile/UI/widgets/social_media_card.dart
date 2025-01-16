import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hola_academy/core/constants/color_manager.dart';

class SocialMediaCard extends StatelessWidget {
  final String name;
  final String iconPath;

  const SocialMediaCard(
      {super.key, required this.name, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 343.w,
          height: 60.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorManager.linearGradient1,
                ColorManager.linearGradient2,
              ],
            ),
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.white,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: Container(
              height: 58.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: SvgPicture.asset(
                      iconPath,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
