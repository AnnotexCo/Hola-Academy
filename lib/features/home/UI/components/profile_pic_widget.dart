import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/api_constants.dart';

class ProfilePicWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String pic;
  const ProfilePicWidget(
      {super.key, this.width, this.height, required this.pic});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 50.w,
      height: height ?? 50.h,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: pic.isEmpty
          ? Container()
          : CircleAvatar(
              backgroundImage: NetworkImage(
                ApiConstants.imagesURLApi + pic,
                //fit: BoxFit.contain,
              ),
            ),
    );
  }
}
