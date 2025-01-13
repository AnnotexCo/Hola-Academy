import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

class TermsDialog extends StatelessWidget {
  const TermsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      backgroundColor: ColorManager.whiteColor,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 694.h,
          maxWidth: 382.w, // Set the width to 382 logical pixels
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: 19.w, right: 15.w, top: 15.h, bottom: 47.h),
            child: Column(
              spacing: 18.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 27.w,
                  children: [
                    Image.asset(
                      ImageManager.hola,
                      width: 60.w,
                      height: 30.77.h,
                    ),
                    Text(
                      AppString.termsTitle,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Column(
                  spacing: 8.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Title(title: AppString.bookingFees),
                    SubTitle(
                      subTitle: AppString.bookingFees1,
                    ),
                    SubTitle(subTitle: AppString.bookingFees2),
                  ],
                ),
                Column(
                  spacing: 8.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Title(title: AppString.paymentOptions),
                    SubTitle(
                      subTitle: AppString.paymentOptions1,
                    ),
                  ],
                ),
                Column(
                  spacing: 8.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Title(title: AppString.paymentPolicies),
                    SubTitle(
                      subTitle: AppString.paymentPolicies1,
                    ),
                    SubTitle(subTitle: AppString.paymentPolicies2),
                    SubTitle(subTitle: AppString.paymentPolicies3),
                    SubTitle(subTitle: AppString.paymentPolicies4),
                    SubTitle(subTitle: AppString.paymentPolicies5),
                    SubTitle(subTitle: AppString.paymentPolicies6),
                    SubTitle(subTitle: AppString.paymentPolicies7),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        
                        Navigator.pop(context); // Close dialog
                      },
                      child: Container(
                        width: 120.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: ColorManager.primaryOrangeColor,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Center(
                          child: Text(
                            'Agree',
                            style: TextStyle(
                                color: ColorManager.whiteColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Close dialog
                      },
                      child: Container(
                        width: 120.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: ColorManager.whiteColor,
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(
                            color:
                                ColorManager.primaryOrangeColor, // Border color
                            width: 1.w, // Border width
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Disagree',
                            style: TextStyle(
                                color: ColorManager.primaryOrangeColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  final String title;
  const Title({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: ColorManager.darkGreyForFontColor),
    );
  }
}

class SubTitle extends StatelessWidget {
  final String subTitle;
  const SubTitle({super.key, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 3.w,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 3.h, right: 6.w),
          child: SvgPicture.asset(ImageManager.ellipse),
        ),
        Text(
          subTitle,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: ColorManager.lightGreyForFontColor),
        )
      ],
    );
  }
}
