import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/color_manager.dart';

class GeneralTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final bool readOnly;
  final bool? isFill;
  final bool? isBorder;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final double? height;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? errorStyle;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius;
  final Color? iconColor;
  final int? maxLines; 

  const GeneralTextFormField({
    super.key,
    required this.label,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.readOnly = false,
    this.isFill = true,
    this.isBorder = false,
    this.controller,
    this.keyboardType,
    this.validator,
    this.onTap,
    this.height,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.errorStyle,
    this.fillColor,
    this.contentPadding,
    this.borderRadius,
    this.iconColor,
     this.maxLines,
  });

  // Helper method to create an Icon widget from IconData
  static Widget createIcon(IconData icon, {Color? color, double? size}) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24.w,
        right: 33.w,
        top: 9.h,
        bottom: 7.h,
      ),
      child: Icon(
        icon,
        size: size ?? 24.sp,
        color: color ?? ColorManager.textRedColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: EdgeInsets.only(left: 8.w, bottom: 8.h),
          child: Text(
            label,
            style: labelStyle ??
                TextStyle(
                  fontSize: 16.sp,
                  color: ColorManager.textRedColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),

        // Input Field
        SizedBox(
          height: height ?? 60.h,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.text,
            validator: validator,
            obscureText: isPassword,
            readOnly: readOnly,
            maxLines: maxLines,
            onTap: onTap,
            style: textStyle ??
                TextStyle(
                  color: ColorManager.textRedColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
            decoration: InputDecoration(
              hintText: hint,
              iconColor: iconColor ?? ColorManager.textRedColor,
              hintStyle: hintStyle ??
                  TextStyle(
                    color: ColorManager.textRedColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
              errorStyle: errorStyle ??
                  TextStyle(
                    color: ColorManager.errorRedColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              filled: isFill,
              fillColor: fillColor ?? ColorManager.backgroundPinkColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                borderSide: isBorder == false
                    ? BorderSide.none
                    : BorderSide(
                        color: ColorManager.textRedColor,
                      ),
              ),
              contentPadding: contentPadding ??
                  EdgeInsets.symmetric(
                    vertical: 15.h,
                    horizontal: 20.w,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
