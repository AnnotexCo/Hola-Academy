import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/components/custom_colored_outline_button.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/constants/color_manager.dart';
import '../../../profile/Data/Model/user_model.dart';

class PersonalInfoCard extends StatelessWidget {
  final UserModel? userData;
  final VoidCallback? onEditPressed;
  const PersonalInfoCard({
    super.key,
    required this.userData,
    this.onEditPressed,
  });

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
                color: ColorManager.errorRedColor,
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
                  child: _buildProfileImage(userData?.profileImage?.path),
                ),
                SizedBox(width: 40.0.w),

                // User Information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(Icons.person, userData?.name ?? 'N/A'),
                      SizedBox(height: 8.0.h),
                      _buildInfoRow(
                        Icons.location_on,
                        userData?.address ?? 'Address not provided',
                      ),
                      SizedBox(height: 8.0.h),
                      _buildInfoRow(Icons.email, userData?.email ?? 'N/A'),
                      SizedBox(height: 8.0.h),
                      _buildInfoRow(
                        Icons.phone,
                        userData?.phoneNumber ?? 'Phone not provided',
                      ),
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
                onTap: onEditPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return Icon(
        Icons.person,
        size: 80.0.sp,
        color: Colors.grey,
      );
    }

    final String imageUrl = '${ApiConstants.imagesURLApi}$imagePath';

    return CachedNetworkImage(
      imageUrl: imageUrl,
      cacheKey: imageUrl, //  Ensures correct caching
      width: 80.0.w,
      height: 80.0.h,
      fit: BoxFit.cover,
      memCacheHeight: 160, //  Limit memory cache size
      memCacheWidth: 160,
      maxWidthDiskCache: 200, //  Reduce disk cache size
      maxHeightDiskCache: 200,
      fadeInDuration: Duration(milliseconds: 300), //  Smooth transition
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) {
        return Icon(
          Icons.person,
          size: 80.0.sp,
          color: Colors.grey, // Fallback icon color
        );
      },
    );
  }

  // Widget for building each row of user info with an icon
  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18.0.sp, color: ColorManager.errorRedColor),
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
