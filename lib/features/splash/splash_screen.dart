import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'dart:async';

import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:jumping_dot/jumping_dot.dart';

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
            Image.asset(
              ImageManager.hola,
              width: 298.w,
              height: 152.h,
            ),
            SizedBox(height: 20.h),
            JumpingDots(
              color: ColorManager.primaryOrangeColor,
              radius: 15.r,
              numberOfDots: 3,

              animationDuration: Duration(milliseconds: 600),
              // animationDuration = Duration(milliseconds: 200),
            ),
          ],
        ),
      ),
    );
  }
}
