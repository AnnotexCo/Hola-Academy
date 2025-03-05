import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/color_manager.dart';

class LevelSelector extends StatefulWidget {
  // A callback function to be called when a level is selected
  final Function(int) onLevelSelected;

  const LevelSelector({super.key, required this.onLevelSelected});

  @override
  LevelSelectorState createState() => LevelSelectorState();
}

class LevelSelectorState extends State<LevelSelector> {
  int _selectedLevel = 1;  // Default is Level A (1)

  void _onLevelTap(int level) {
    setState(() {
      _selectedLevel = level;
    });
    widget.onLevelSelected(level);  // Call the provided callback function with the numeric value
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.w,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildLevelButton('Level A', _selectedLevel == 1, 1),
        buildLevelButton('Level B', _selectedLevel == 2, 2),
        buildLevelButton('Level D', _selectedLevel == 3, 3),
      ],
    );
  }

  Widget buildLevelButton(String text, bool isActive, int level) {
    return GestureDetector(
      onTap: () => _onLevelTap(level),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isActive ? ColorManager.primaryOrangeColor : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            if (!isActive)
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
