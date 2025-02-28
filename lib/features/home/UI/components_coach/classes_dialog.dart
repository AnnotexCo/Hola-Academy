import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ClassesDialog extends StatelessWidget {
  final String title;
  final Function() onCancel;
  final List<Map<String, dynamic>> options;
  final Function(String) onOptionSelected;

  const ClassesDialog({
    super.key,
    required this.title,
    required this.onCancel,
    required this.options,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0.r)),
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          // Main Container
          Container(
            height: 580.h,
            width: 397.w,
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 24.h),
            margin: EdgeInsets.only(top: 16.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF5E9),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20.h),

                // Title
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffF09C1F),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 70.h),

                // Options List
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                  width: 300.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurStyle: BlurStyle.outer,
                          color: Color(0xCED2D9C9),
                          blurRadius: 2,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ]),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: options.length,
                    separatorBuilder: (_, __) =>
                        Divider(color: Colors.grey[300]),
                    itemBuilder: (context, index) {
                      var item = options[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          onOptionSelected(item['title']); // Open next dialog
                        },
                        child: Row(
                          children: [
                            CachedNetworkImage(
                                width: 35.w, height: 35.h, imageUrl: "http://109.176.197.232:3100/static-uploads/${item['icon']}",),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                item['title'],
                                style: TextStyle(
                                    color: Color(0xff899197),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios,
                                size: 16, color: Colors.grey),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Cancel Button
          Positioned(
            right: 15.w,
            top: 30.h,
            child: GestureDetector(
              onTap: onCancel,
              child: Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFC96852),
                  borderRadius: BorderRadius.circular(31.04.r / 2),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xC9685280),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
