import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          CustomPaint(
            size: Size(60.w, 60.h),
            painter: HexagonPainter(
              color,
            ),
          ),
          Center(
            child: ClipOval(
              child: SizedBox(
                width: 36.w,
                height: 36.h,
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
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

    /* path.moveTo(width * 0.7.w, 0.h); // Top point
    path.lineTo(width * 1.3.w, height * 0.4.h); // Top-right
    path.lineTo(width * 1.3.w, height.h * 1.5.h); // Bottom-right
    path.lineTo(width * 0.7.w, height * 1.6.h); // Bottom
    path.lineTo(0.w, height.h * 1.3); // Bottom-left
    path.lineTo(0.w, height * 0.4.h); // Top-left
    path.close();*/

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
 /*path.moveTo(width * 0.5.w, height * 0.1.h); // Top point
    path.lineTo(width.w, height * 0.35.h); // Top-right
    path.lineTo(width.w, height.h); // Bottom-right
    path.lineTo(width * 0.5.w, height * 1.25.h); // Bottom
    path.lineTo(width * 0.01.w, height.h); // Bottom-left
    path.lineTo(0.w, height * 0.38.h); // Top-left
    path.close();*/