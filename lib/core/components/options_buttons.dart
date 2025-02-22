import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/color_manager.dart';

// Generalized Option Button Widget
Widget buildOptionButton(String text, bool isActive, VoidCallback onPressed) {
  return GestureDetector(
    onTap: onPressed, // Trigger action when the button is clicked
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isActive ? ColorManager.primaryOrangeColor : ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          if (!isActive)
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2), 
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? ColorManager.whiteColor : Colors.grey,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

// Generalized Option Selector
class OptionSelector extends StatelessWidget {
  final List<String> options;
  final String activeOption;
  final Function(String) onOptionSelected;

  const OptionSelector({
    super.key,
    required this.options,
    required this.activeOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: options
            .map(
              (option) => buildOptionButton(
                option,
                activeOption == option, // Determine if the button is active
                () => onOptionSelected(option), // Pass selected option to callback
              ),
            )
            .toList(),
      ),
    );
  }
}
