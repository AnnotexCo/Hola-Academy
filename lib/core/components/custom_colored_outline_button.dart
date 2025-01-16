import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/color_manager.dart';

class CustomColoredOutlineButton extends StatelessWidget {
  final void Function()? onTap;
  final double width;
  final double height;
  final double radius;
  final String title;
  final TextStyle style;
  const CustomColoredOutlineButton(
      {super.key,
      required this.radius,
      required this.title,
      required this.style,
      required this.height,
      required this.width,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: ColorManager.primaryOrangeColor, // Border color
            width: 1.w, // Border width
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: style,
          ),
        ),
      ),
    );
  }
}
