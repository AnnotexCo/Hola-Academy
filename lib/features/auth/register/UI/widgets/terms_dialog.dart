import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hola_academy/core/components/custom_colored_outline_button.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

class TermsDialog extends StatelessWidget {
  void Function()? onAgree;
  void Function()? onDisagree;
  TermsDialog({super.key, required this.onAgree, required this.onDisagree});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 120.h, horizontal: 29.w),
      child: Container(
        height: 694.h,
        width: 382.w,
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(15.r),
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
                  // spacing: 27.w,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      ImageManager.hola,
                      width: 60.w,
                      height: 30.77.h,
                    ),
                    Text(
                      AppString.termsTitle,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400),
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
                      onTap: onAgree,
                      child: Container(
                        width: 120.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: ColorManager.primaryOrangeColor,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Center(
                          child: Text(
                            AppString.agree,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: ColorManager.whiteColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    CustomColoredOutlineButton(
                        width: 120.w,
                        height: 30.h,
                        radius: 15.r,
                        title: AppString.disagree,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: ColorManager.primaryOrangeColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                        onTap: onDisagree),
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
          decoration: TextDecoration.none,
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
    return SizedBox(
      width: 340.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 3.w,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 3.h, right: 6.w),
            child: SvgPicture.asset(ImageManager.ellipse),
          ),
          Expanded(
            child: Text(
              subTitle,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'Poppins',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.lightGreyForFontColor),
            ),
          )
        ],
      ),
    );
  }
}
