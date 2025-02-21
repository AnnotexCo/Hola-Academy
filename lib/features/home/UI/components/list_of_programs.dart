import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/features/home/UI/components/program_card.dart';

class ListOfPrograms extends StatelessWidget {
  final String title;
  final double? hight;
  final double? width;
  final String? text;
  final Color? color;
  final EdgeInsets? edgeInsets;
  final Color? backgroundColor;
  const ListOfPrograms(
      {super.key,
      required this.title,
      this.hight,
      this.width,
      this.edgeInsets,
      this.text,
      this.color,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgeInsets ?? EdgeInsets.only(left: 18.0.w, top: 0, bottom: 0),
      child: SizedBox(
        height: 230.h,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 18.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff9DA3A8),
                )),
            SizedBox(
              height: 180.h,
              width: double.infinity,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 18.w),
                      child: ProgramCard(
                        backgroundColor: backgroundColor,
                        color: color,
                        text: text,
                        height: hight?.h,
                        width: width?.w,
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
