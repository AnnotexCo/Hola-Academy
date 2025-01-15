import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

class CustomDropDownSelection extends StatelessWidget {
  final String? value;
  final String hint;
  final String label;
  final List<String> options;
  final Function(String?) onChanged;

  CustomDropDownSelection({super.key,
    required this.value,
    required this.hint,
    required this.label,
    required this.options,
    required this.onChanged,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: ColorManager.textRedColor,
              ),
            )),
        Center(
          child: Container(
            height: 60.h,
            padding: EdgeInsets.symmetric(horizontal: 19.w),
            decoration: BoxDecoration(
              color: ColorManager.backgroundPinkColor, // Light background color
              borderRadius: BorderRadius.circular(12.r), // Rounded corners
            ),
            child: DropdownButton<String>(
              value: value, // Current selected value
              isExpanded: true, // Dropdown matches the container width
              underline: const SizedBox(), // Removes default underline
              icon: SvgPicture.asset(
                ImageManager.roundDoubleAltArrowDown,
                width: 24.w,
                height: 24.h,
              ),
              dropdownColor:
                  ColorManager.backgroundPinkColor, // Dropdown menu background
              style: TextStyle(
                color: ColorManager.textRedColor, // Text color
                fontSize: 18, // Font size
                fontWeight: FontWeight.w400, // Font weight
              ),
              hint: Padding(
                padding: EdgeInsets.only(left: 19.w),
                child: Text(
                  hint, // Placeholder text
                  style: TextStyle(
                    color: ColorManager.textRedColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              items: options.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      // Default text color
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );;
  }
}