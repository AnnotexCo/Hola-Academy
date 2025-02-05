import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ComponentDialog extends StatelessWidget {
  final String title;
  final String image;
  const ComponentDialog({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 17.w,
          children: [
            SvgPicture.asset(height: 36.h, width: 36.w, image),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: Color(0xff899197)),
            )
          ],
        ),
        Icon(
          Icons.keyboard_arrow_right_sharp,
          color: Color(0xffBB4227),
        )
      ],
    );
  }
}
