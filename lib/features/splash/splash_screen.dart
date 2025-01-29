import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'dart:async';

import 'package:hola_academy/core/constants/image_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacementNamed(Routes.onboarding);
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageManager.hola, width: 298.w, height: 152.h,),
            SizedBox(height: 20.h),
            TypingIndicator(),
          ],
        ),
      ),
    );
  }
}

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator> {
  int _currentDot = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAnimation() {
    _timer = Timer.periodic(Duration(milliseconds: 600), (timer) {
      setState(() {
        _currentDot = (_currentDot + 1) % 3;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Padding(
          padding: EdgeInsets.only(
              left: 2.0, right: 2.0, bottom: _currentDot == index ? 12.0 : 0.0),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: 15.w,
            height: 15.h,
            decoration: BoxDecoration(
              color: ColorManager.primaryOrangeColor,
              //_currentDot == index ? Colors.grey[600] : Colors.grey[300],
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }
}
