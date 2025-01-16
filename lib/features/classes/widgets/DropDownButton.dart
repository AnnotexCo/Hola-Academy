import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/color_manager.dart';

class DropDown extends StatelessWidget {
  const DropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton2(
      underline: null,
      hint: null,
      disabledHint: null,
      customButton: Container(
        height: 40.h,
        width: 40.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: Color(0xffFEF5E9),
        ),
        child: Icon(
          color: Color(0xffD58753),
          Icons.format_list_bulleted,
          size: 25.sp,
        ),
      ),
      items: [
        ...MenuItems.firstItems.map(
          (item) => DropdownMenuItem<MenuItem>(
            value: item,
            child: MenuItems.buildItem(item),
          ),
        ),
        ...MenuItems.secondItems.map(
          (item) => DropdownMenuItem<MenuItem>(
            value: item,
            child: MenuItems.buildItem(item),
          ),
        ),
      ],
      onChanged: (value) {
        MenuItems.onChanged(context, value!);
      },
      dropdownStyleData: DropdownStyleData(
        elevation: 2,
        width: 130.w,
        maxHeight: 120.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: ColorManager.backgroundColor,
        ),
        // Adjust the horizontal offset here
        offset: const Offset(-10, 0), // Move 10 pixels to the left
      ),
      menuItemStyleData: MenuItemStyleData(
        customHeights: [
          ...List<double>.filled(MenuItems.firstItems.length, 26.h),
          ...List<double>.filled(MenuItems.secondItems.length, 26.h),
        ],
        padding: EdgeInsets.only(
          left: 20.w,
          right: 32.w,
        ),
      ),
    );
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [classes, available];
  static const List<MenuItem> secondItems = [programs];

  static const classes =
      MenuItem(text: 'My Classes', icon: Icons.account_box_rounded);
  static const available = MenuItem(text: 'Available', icon: Icons.backup);
  static const programs = MenuItem(text: 'All Programs', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Text(
      item.text,
      style: TextStyle(
        fontSize: 12.sp,
        color: Colors.black,
      ),
    );
  }

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.classes:
        break;

      case MenuItems.available:
        break;

      case MenuItems.programs:
        break;
    }
  }
}
