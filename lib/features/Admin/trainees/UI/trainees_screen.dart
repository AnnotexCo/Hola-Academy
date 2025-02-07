import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/components/general_text_form_field.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

import '../../../home/components_coach/find_trainees_screen.dart';
import 'widgets/custom_list_view.dart';

class TraineesScreen extends StatelessWidget {
  const TraineesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final traineesData = [
      {'name': 'Robert Fox', 'phone': '01228569715'},
      {'name': 'Jane Doe', 'phone': '01234567890'},
      {'name': 'John Smith', 'phone': '01111222333'},
    ];

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
                        height: 37.h,
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
                            horizontal: 12.w, vertical: -4),
                        borderRadius: 8.r,
                      ),
                    ),
                  ),
                  SizedBox(width: 19.w),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5BD69),
                      minimumSize: Size(128.w, 42.h),
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
            SizedBox(height: 20.h),
            Expanded(
              child: CustomListView(
                data: traineesData,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
