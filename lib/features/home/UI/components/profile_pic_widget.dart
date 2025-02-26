import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/api_constants.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePicWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String pic;

  const ProfilePicWidget({super.key, this.width, this.height, required this.pic});

  @override
  Widget build(BuildContext context) {
    double imageSize = width ?? 50.w;

    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorManager.lightYellow, 
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: '${ApiConstants.imagesURLApi}$pic',
          fit: BoxFit.cover,
          placeholder: (context, url) => ShimmerCircle(size: imageSize), 
          errorWidget: (context, url, error) => CircleAvatar(
            backgroundColor: ColorManager.lightYellow,
            child: const Icon(Icons.person, color: Colors.white, size: 30),
          ),
        ),
      ),
    );
  }
}

class ShimmerCircle extends StatelessWidget {
  final double size;

  const ShimmerCircle({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
      ),
    );
  }
}
