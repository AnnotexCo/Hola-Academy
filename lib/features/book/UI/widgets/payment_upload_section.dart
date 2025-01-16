  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/components/title_widget.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/constants/color_manager.dart';
import '../../../../core/constants/image_manager.dart';

Widget buildPaymentUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleWidget(title: AppString.uploadPaymentProofTitle),
        SizedBox(height: 24.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: ColorManager.backgroundLightPink,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Column(
              children: [
                SvgPicture.asset(
                  ImageManager.upload,
                  height: 80.h,
                  width: 80.w,
                  fit: BoxFit.contain,
                ),
                TextButton(
                  onPressed: () {},
                  child: TitleWidget(
                    title: AppString.upload,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
