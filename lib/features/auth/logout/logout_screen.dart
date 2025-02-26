import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                AppString.logingOut,
                style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.primaryOrangeColor),
              ),
            ),
            SizedBox(height: 47.h),
            SizedBox(
                height: 100.h,
                width: 100.w,
                child: AnimatedGradientCircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}

class AnimatedGradientCircularProgressIndicator extends StatefulWidget {
  const AnimatedGradientCircularProgressIndicator({super.key});

  @override
  AnimatedGradientCircularProgressIndicatorState createState() =>
      AnimatedGradientCircularProgressIndicatorState();
}

class AnimatedGradientCircularProgressIndicatorState
    extends State<AnimatedGradientCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Animation duration
    )..repeat(); // Repeat the animation indefinitely

    // Initialize the animation
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {}); // Update the UI on every animation tick
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientCircularProgressIndicator(
      gradient: LinearGradient(
        colors: [
          ColorManager.linearGradient1,
          ColorManager.linearGradient2,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      value: _animation.value, // Use the animated value
      strokeWidth: 15.w,
    );
  }
}

class GradientCircularProgressIndicator extends StatelessWidget {
  final double strokeWidth;
  final Gradient gradient;
  final double value;

  const GradientCircularProgressIndicator({
    super.key,
    this.strokeWidth = 8.0,
    required this.gradient,
    this.value = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(100), // Adjust the size as needed
      painter: _GradientCircularProgressPainter(
        strokeWidth: strokeWidth,
        gradient: gradient,
        value: value,
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  final double strokeWidth;
  final Gradient gradient;
  final double value;

  _GradientCircularProgressPainter({
    required this.strokeWidth,
    required this.gradient,
    required this.value,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: size.width / 2,
    );

    // Create a shader from the gradient
    final Paint paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw the background circle
    final Paint backgroundPaint = Paint()
      ..color = ColorManager.linearGradient1
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
        size.center(Offset.zero), size.width / 2, backgroundPaint);

    // Draw the progress arc
    final double sweepAngle = 2 * 3.14 * value; // Convert value to radians
    canvas.drawArc(
      rect,
      -3.14 / 2, // Start angle (12 o'clock position)
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
