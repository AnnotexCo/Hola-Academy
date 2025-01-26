import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

class MoneyCard extends StatelessWidget {
  final String money;
  final String title;
  final String icon;
  const MoneyCard({super.key, required this.money, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132.h,
      width: 153.w,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.all(
          Radius.circular(12.r),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(icon),
                Text(
                  title,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: ColorManager.textRedColor,
              child: Center(
                  child: Text(
                '\$$money',
                style: TextStyle(
                    color: ColorManager.whiteColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
