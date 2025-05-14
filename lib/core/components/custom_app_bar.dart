import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/color_manager.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? widget;
  final void Function()? onPressed;
  final String? title;
  final bool isBack;
  const CustomAppBar(
      {super.key, this.onPressed, this.widget, this.title, this.isBack = true});

  @override
  Widget build(BuildContext context) {
    //Note Dont use SafeArea with Appbar
    return Container(
      height: 115.h,
      width: 462.w,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(2, 2))
        ],
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25.r),
            bottomLeft: Radius.circular(25.r)),
        color: ColorManager.whiteColor,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 67.h, right: 30.w, left: 28.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isBack)
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 24.r,
                    color: ColorManager.redMagmaColor,
                  )),
            Spacer(),
            Text(
              title ?? "Default name",
              style: TextStyle(
                  color: ColorManager.primaryOrangeColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600),
            ),
            Spacer(),
            widget ?? SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
