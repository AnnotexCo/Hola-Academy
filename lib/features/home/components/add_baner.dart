import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddBaner extends StatelessWidget {
  const AddBaner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 107.h,
      width: 380.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Image.asset(
          "assets/images/addpaner.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
