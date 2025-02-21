import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import '../../Data/Model/programs_model.dart';

class ProgramLevlDetailWidget extends StatelessWidget {
  final LevelModel level;
  const ProgramLevlDetailWidget({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 392.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4,
              spreadRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: Image.asset(
                ImageManager.onBoardingImage3,
                height: 170.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Title & Price Row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    level.name,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff2D3135),
                    ),
                  ),
                  Text(
                    "\$${level.price}",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffBB4227),
                    ),
                  ),
                ],
              ),
            ),

            // Program Details
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow("Classes:", "8"),
                  SizedBox(height: 10.h),

                  _buildDetailRow("Lessons:", "${level.lessonNumber}"),

                  SizedBox(height: 10.h),
                  _buildDetailRow("Suitable For:", "Male & Female"),
                  SizedBox(height: 10.h),

                  // General Description
                  Text(
                    "How Does it work?",
                    style: _boldStyle(),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    level.clarification,
                    style: _normalStyle(),
                  ),

                  SizedBox(height: 10.h),

                  // Additional Description
                  Text(
                    level.description,
                    style: _boldStyle(),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  // Helper function to create a consistent detail row
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: "$title ", style: _boldStyle()),
            TextSpan(text: value, style: _normalStyle()),
          ],
        ),
      ),
    );
  }

  // Bold Text Style
  TextStyle _boldStyle() {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: Color(0xFF3C4146),
    );
  }

  // Normal Text Style
  TextStyle _normalStyle() {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: Color(0xFF626A72),
    );
  }
}
