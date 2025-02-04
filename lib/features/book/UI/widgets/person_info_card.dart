import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/components/custom_colored_outline_button.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

import '../../../../core/constants/color_manager.dart';

class PersonalInfoCard extends StatelessWidget {
  const PersonalInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Your Personal Information',
              style: TextStyle(
                fontSize: 16.0.sp,
                fontWeight: FontWeight.bold,
                color: ColorManager.textRedColor,
              ),
            ),
            SizedBox(height: 16.0.h),

            // Row for Image and User Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0.r),
                  child: Image.asset(
                    ImageManager.pic,
                    width: 80.0.w,
                    height: 80.0.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 40.0.w),

                // User Information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(Icons.person, 'Mr. Alex Hayden'),
                      SizedBox(height: 8.0.h),
                      _buildInfoRow(
                          Icons.location_on, 'Anna Nagar, Puducherry'),
                      SizedBox(height: 8.0.h),
                      _buildInfoRow(Icons.email, 'Alex.Hayden@gmail.com'),
                      SizedBox(height: 8.0.h),
                      _buildInfoRow(Icons.phone, '01258672352'),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.0.h),

            // Edit Button
            Align(
              alignment: Alignment.centerRight,
              child: CustomColoredOutlineButton(
                radius: 15.r,
                title: 'Edit',
                style: TextStyle(
                    fontSize: 14.0.sp, color: ColorManager.primaryOrangeColor),
                height: 21.h,
                width: 60.w,
                backgroundColor: Colors.transparent,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for building each row of user info with an icon
  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18.0.sp, color: ColorManager.textRedColor),
        SizedBox(width: 8.0.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.0.sp,
              color: ColorManager.blackFontColor,
            ),
          ),
        ),
      ],
    );
  }
}
