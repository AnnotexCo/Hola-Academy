import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:shimmer/shimmer.dart';

class AdminClipOval extends StatelessWidget {
  final Color color;
  final String image;

  const AdminClipOval({super.key, required this.color, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      width: 56.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Hexagon Background
          CustomPaint(
            size: Size(60.w, 60.h),
            painter: HexagonPainter(color),
          ),

          // Profile Image with CachedNetworkImage
          Center(
            child: ClipOval(
              child: SizedBox(
                width: 36.w,
                height: 36.h,
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      AdminClipShimmer(width: 36.w, height: 36.h),
                  // Fallback image on error
                  errorWidget: (context, url, error) => CircleAvatar(
                    backgroundColor: ColorManager.lightYellow,
                    child:
                        const Icon(Icons.person, color: Colors.white, size: 30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HexagonPainter extends CustomPainter {
  final Color color;
  HexagonPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    // final path = Path();
    final width = size.width;
    final height = size.height;

    // Define the six points of the hexagon
    final path = Path()
      ..moveTo(width * 0.5, 0) // Top-center
      ..lineTo(width, height * 0.25) // Top-right
      ..lineTo(width, height * 0.75) // Bottom-right
      ..lineTo(width * 0.5, height) // Bottom-center
      ..lineTo(0, height * 0.75) // Bottom-left
      ..lineTo(0, height * 0.25) // Top-left
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
class AdminClipShimmer extends StatelessWidget {
  final double width;
  final double height;

  const AdminClipShimmer(
      {super.key, required this.width, required this.height});

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
          borderRadius: BorderRadius.circular(50.r),
        ),
      ),
    );
  }
}
