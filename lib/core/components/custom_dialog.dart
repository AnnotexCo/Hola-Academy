import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final Function() onCancel;
  final List<Widget> components;

  const CustomDialog({
    super.key,
    required this.title,
    this.imageUrl,
    required this.onCancel,
    required this.components,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0.r),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          // Main Content Container
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            margin: EdgeInsets.only(top: 16.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF5E9),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Centered User Image and Title
                if (imageUrl != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundImage: AssetImage(imageUrl!),
                      ),
                      SizedBox(width: 19.w),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFF09C1F),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                SizedBox(height: 16.h),

                // Components
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: components,
                ),
              ],
            ),
          ),

          // Cancel Button
          Positioned(
            right: 9.w,
            top: 25.h,
            child: GestureDetector(
              onTap: onCancel,
              child: Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFC96852),
                  borderRadius: BorderRadius.circular(31.04.r / 2),
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
