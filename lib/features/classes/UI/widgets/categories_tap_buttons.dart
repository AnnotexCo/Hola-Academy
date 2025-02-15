import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/color_manager.dart';
import '../../Data/Model/programs_model.dart';

class CategoryFilterButtons extends StatefulWidget {
  final List<CategoryModel> categories;
  final Function(int) onCategorySelected;
  final int? selectedCategoryId;

  const CategoryFilterButtons({
    required this.categories,
    required this.onCategorySelected,
    this.selectedCategoryId,
    super.key,
  });

  @override
  _CategoryFilterButtonsState createState() => _CategoryFilterButtonsState();
}

class _CategoryFilterButtonsState extends State<CategoryFilterButtons> {
  int? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    selectedCategoryId = widget.selectedCategoryId;
  }

  @override
  Widget build(BuildContext context) {
    // Remove duplicate categories
    final uniqueCategories = widget.categories.toSet().toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: uniqueCategories.map((category) {
          bool isActive = selectedCategoryId == category.id;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategoryId = category.id;
              });
              widget.onCategorySelected(category.id);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: buildLevelButton(category.name, isActive),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Reusable Category Button
Widget buildLevelButton(String text, bool isActive) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
    decoration: BoxDecoration(
      color: isActive ? ColorManager.primaryOrangeColor : Colors.white,
      borderRadius: BorderRadius.circular(20.r),
      boxShadow: isActive
          ? []
          : [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
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
  );
}
