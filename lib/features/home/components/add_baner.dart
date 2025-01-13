import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddBaner extends StatelessWidget {
  const AddBaner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 108.h,
      width: 362.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Image.asset(
        "assets/images/addpaner.png",
        fit: BoxFit.contain,
      ),
    );
  }
}
