import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePicWidget extends StatelessWidget {
  final double? width;
  final double? height;
  const ProfilePicWidget({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 50.w,
      height: height ?? 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Image.asset(
        "assets/images/profilepic.png",
        fit: BoxFit.contain,
      ),
    );
  }
}
