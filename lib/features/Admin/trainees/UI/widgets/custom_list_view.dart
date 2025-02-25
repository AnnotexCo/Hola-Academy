import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hola_academy/core/components/custom_dialog.dart';
import 'package:hola_academy/core/components/general_text_form_field.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/profile/Data/Model/trainee_model.dart';
import 'package:hola_academy/features/profile/Data/Model/user_model.dart';

import '../../../../../core/constants/color_manager.dart';

class CustomListView extends StatelessWidget {
  final List<Users> data; // List of trainee data
  final double itemHeight;
  final Color backgroundColor;
  final Color borderColor;
  final String profileImagePath;

  const CustomListView({
    super.key,
    required this.data,
    this.itemHeight = 74.0,
    this.backgroundColor = ColorManager.backgroundLightPink,
    this.borderColor = ColorManager.textRedColor,
    this.profileImagePath = 'assets/images/profilepic.png',
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final trainee = data[index];
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return CustomDialog(
                    title: trainee.name,
                    imageUrl: profileImagePath,
                    onCancel: () {
                      Navigator.of(context).pop();
                    },
                    components: [
                      GeneralTextFormField(
                        height: 45.h,
                        hint: trainee.email,
                        label: AppString.email,
                        labelStyle: TextStyle(
                          fontSize: 18.sp,
                          color: ColorManager.blackFontColor,
                          fontWeight: FontWeight.w500,
                        ),
                        isFill: true,
                        readOnly: true,
                        fillColor: ColorManager.whiteColor,
                        isBorder: true,
                        suffixIcon: Icon(
                          Icons.email,
                          color: ColorManager.textRedColor,
                        ),
                      ),
                      GeneralTextFormField(
                        height: 45.h,
                        hint: trainee.phoneNumber,
                        label: AppString.phoneNumber,
                        labelStyle: TextStyle(
                          fontSize: 18.sp,
                          color: ColorManager.blackFontColor,
                          fontWeight: FontWeight.w500,
                        ),
                        isFill: true,
                        readOnly: true,
                        fillColor: ColorManager.whiteColor,
                        isBorder: true,
                        suffixIcon: Icon(
                          Icons.phone,
                          color: ColorManager.textRedColor,
                        ),
                      ),
                      GeneralTextFormField(
                        height: 45.h,
                        hint: 'Educational',
                        label: AppString.category,
                        labelStyle: TextStyle(
                          fontSize: 18.sp,
                          color: ColorManager.blackFontColor,
                          fontWeight: FontWeight.w500,
                        ),
                        isFill: true,
                        fillColor: ColorManager.whiteColor,
                        isBorder: true,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            ImageManager.category,
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),
                      ),
                      GeneralTextFormField(
                        height: 45.h,
                        hint: 'A',
                        label: AppString.level,
                        labelStyle: TextStyle(
                          fontSize: 18.sp,
                          color: ColorManager.blackFontColor,
                          fontWeight: FontWeight.w500,
                        ),
                        isFill: true,
                        fillColor: ColorManager.whiteColor,
                        isBorder: true,
                      ),
                      GeneralTextFormField(
                        height: 45.h,
                        hint: 'Male',
                        label: AppString.gender,
                        labelStyle: TextStyle(
                          fontSize: 18.sp,
                          color: ColorManager.blackFontColor,
                          fontWeight: FontWeight.w500,
                        ),
                        isFill: true,
                        fillColor: ColorManager.whiteColor,
                        isBorder: true,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(ImageManager.gender),
                        ),
                      ),
                      SizedBox(height: 60.h),
                    ]);
              },
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 9.h,
            ),
            child: Container(
              width: double.infinity,
              height: itemHeight.h,
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: borderColor,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(
                      profileImagePath,
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
                                text: trainee.name,
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
                                text: trainee.phoneNumber,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
