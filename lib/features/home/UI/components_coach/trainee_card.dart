import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

import '../../../trainee/widgets/evaluate_dialog.dart';


class TraineeCard extends StatelessWidget {
 final String? name;
  final String? phone;
  const TraineeCard({this.name, this.phone, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 71.h,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4F4),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: const Color(0xFFD32F2F),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              ImageManager.pic,
              width: 50.w,
              height: 50.h,
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: 'Name: ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.textRedColor,
                    ),
                    children: [
                      TextSpan(
                        text: name ?? 'Robert Fox',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.graycolorHeadline,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: 'Phone Number: ',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.textRedColor,
                    ),
                    children: [
                      TextSpan(
                        text: phone ?? "010815121512",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.graycolorHeadline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24.h,
            width: 80.w,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(const Color(0xffF09C1F)),
                padding:
                    WidgetStateProperty.all(EdgeInsets.zero), // Removes padding
                tapTargetSize:
                    MaterialTapTargetSize.shrinkWrap, // Removes extra margin
              ),
              onPressed: () {
                showDialog(
                          context: context,
                          builder: (context) {
                            return EvaluateDialog(
                              imageUrl: ImageManager.pic,
                              traineeName: 'Robert Fox',
                              courseTitle: 'Basic Swimming Techniques',
                              onCancel: () {
                                Navigator.of(context).pop();
                              },
                            );
                          });
              },
              child: Text(
                "Evaluate",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: ColorManager.backgroundColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
