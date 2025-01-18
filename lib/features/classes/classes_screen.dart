import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/components/custom_app_bar.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/features/classes/widgets/program_widget.dart';
import 'package:hola_academy/features/classes/widgets/tap_bar.dart';

import '../../core/constants/app_string.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            spacing: 18.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          CustomAppBar(
            title: AppString.programs,
            widget: PopupMenuButton<String>(
              icon: Icon(Icons.format_list_bulleted_rounded,
                  color: ColorManager.redMagmaColor),
              borderRadius: BorderRadius.circular(12.r),
              color: ColorManager.backgroundColor,
              offset: Offset(-15, 40.h),
              itemBuilder: (context) => [
                PopupMenuItem(
                  height: 17.h,
                  value: 'mark_read',
                  child: Text('My Classes'),
                ),
                PopupMenuItem(
                  height: 17.h,
                  value: 'delete',
                  child: Text('Available'),
                ),
                PopupMenuItem(
                  height: 17.h,
                  value: 'select_all',
                  child: Text('All Programs'),
                ),
              ],
            ),
            onPressed: () {},
          ),
          Padding(
            padding: EdgeInsets.only(left: 32.w),
            child: Text(
              "All Programs",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: ColorManager.graycolorHeadline,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 32.w),
            child: TapBar(),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 28.0.h),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.detailsScreen);
                        },
                        child: ProgramWidget()),
                  );
                }),
          )
        ]));
  }
}
