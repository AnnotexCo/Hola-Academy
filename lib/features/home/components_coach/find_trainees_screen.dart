import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/components/general_text_form_field.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/home/components_coach/listof_trainee.dart';

class FindTraineesScreen extends StatelessWidget {
  const FindTraineesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Center(
              child: Image.asset(
                ImageManager.hola,
                width: 98.w,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              width: 439.w,
              height: 94.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF09C1F),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 16.h,
                      ),
                      child: GeneralTextFormField(
                        height: 45.h,
                        hintStyle: TextStyle(
                          color: ColorManager.graycolorHeadline,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        hint: "Ex. Name, Mobile",
                        fillColor: ColorManager.whiteColor,
                        prefixIcon: Icon(
                          Icons.search,
                          size: 24.sp,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                        ),
                        borderRadius: 8.r,
                      ),
                    ),
                  ),
                  SizedBox(width: 19.w),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5BD69),
                      minimumSize: Size(128.w, 37.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: ColorManager.whiteColor,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Search',
                          style: TextStyle(
                            color: ColorManager.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),
                ],
              ),
            ),
            SizedBox(height: 18.h),
            Row(
              spacing: 40.w,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomOutlinedButton(title: "Level A"),
                CustomOutlinedButton(title: "Educational"),
                CustomOutlinedButton(title: "Private"),
              ],
            ),
            SizedBox(height: 18.h),
            Expanded(
              child: ListofTrainee(),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final String title;

  const CustomOutlinedButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          side: const BorderSide(color: Colors.black12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        onPressed: () {},
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
