import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/api_constants.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/color_manager.dart';
import '../../Data/Model/programs_model.dart';

class ProgramWidget extends StatelessWidget {
  final ProgramsModel program;
  const ProgramWidget({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        '${ApiConstants.imagesURLApi}${program.image?.path}';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                  color: Color(0xCED2D9C9),
                  spreadRadius: 0,
                  blurRadius: 7,
                  blurStyle: BlurStyle.outer)
            ]),
        height: 96.h,
        width: 398.w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 22.w,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  bottomLeft: Radius.circular(12.r)),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: double.infinity,
                width: 110.w,
                fit: BoxFit.cover,
                placeholder: (context, url) => ImageShimmer(
                  width: 110.w,
                  height: double.infinity,
                  borderRadius: 12,
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  size: 36.w,
                  color: ColorManager.redMagmaColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 13.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 2.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    program.name,
                    // "Private",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff2D3135),
                    ),
                  ),
                  Row(
                    spacing: 20.w,
                    children: [
                      Text(
                        "Min Age : ${program.minAge}",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffBBC0C3),
                        ),
                      ),
                      Text(
                        "Max Age : ${program.maxAge}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffBBC0C3),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Suitable For: ${program.allowedGender}",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffBBC0C3),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageShimmer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ImageShimmer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
      ),
    );
  }
}
