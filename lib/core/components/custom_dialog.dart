import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

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
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
          ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: imageUrl!,
                            width: 50.w,
                            height: 50.h,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => _shimmerEffect(),
                            errorWidget: (context, url, error) =>
                                _defaultProfileImage(),
                          ),
                        ),
                        SizedBox(width: 19.w),
                        SizedBox(
                          width: 200.w,
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFF09C1F),
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow
                                .ellipsis, // Truncate with dots if overflow
                            maxLines: 1, //
                          ),
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
        ),
      ),
    );
  }

  /// Shimmer Effect for Loading State
  Widget _shimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 60.r,
        height: 60.r,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  /// Default Profile Image in case of error
  Widget _defaultProfileImage() {
    return Container(
      width: 60.r,
      height: 60.r,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.person, size: 30.r, color: Colors.white),
    );
  }
}
