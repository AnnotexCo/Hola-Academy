import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constants/color_manager.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData? prefixIcon;
  final String? suffixIcon;
  final bool isPassword;
  final bool readOnly;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function()? onTap;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.readOnly = false,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              color: ColorManager.textRedColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: 60.h,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.text,
            validator: validator,
            obscureText: isPassword,
            readOnly: readOnly,
            decoration: InputDecoration(
              hintText: hint,
              iconColor: ColorManager.textRedColor,
              hintStyle: TextStyle(
                color: ColorManager.textRedColor,
                fontSize: 16.sp,
              ),
              errorStyle: TextStyle(
                color: ColorManager
                    .errorRedColor, // Change this to your desired error text color
                fontSize: 12.sp, // Adjust font size if needed
                fontWeight: FontWeight.w400, // Customize weight
              ),
              prefixIcon: prefixIcon != null
                  ? Padding(
                      padding: EdgeInsets.only(
                          left: 24.w, right: 33.w, top: 9.h, bottom: 7.h),
                      child: Icon(
                        prefixIcon!,
                        weight: 24.w,
                        size: 24.sp,
                        color: ColorManager.textRedColor,
                      ))
                  : null,
              suffixIcon: suffixIcon != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ),
                      child: SvgPicture.asset(
                        suffixIcon!,
                        height: isPassword ? 15.w : 24.h,
                        width: 24.w,
                      ),
                    )
                  : null,
              filled: true,
              fillColor: ColorManager.backgroundPinkColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 15.h,
                horizontal: 20.w,
              ),
            ),
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
