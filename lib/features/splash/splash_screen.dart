import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'dart:async';

import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/core/local_db/onboarding_db.dart';
import 'package:jumping_dot/jumping_dot.dart';

import '../../core/local_db/save_token.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 6));

    bool hasSeenOnboarding = await OnboardingStatusDB.hasSeenOnboarding();

    String? token = await SaveTokenDB.getToken();
    String? role = await SaveTokenDB.getRole();

    if (!mounted) return; // Ensure widget is still active before navigating

    Future.microtask(() {
      if (!hasSeenOnboarding) {
        if (mounted) Navigator.pushReplacementNamed(context, Routes.onboarding);
        OnboardingStatusDB.setOnboardingSeen();
      } else if (token == null || token.isEmpty) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, Routes.loginScreen);
        }
      } else {
        // Role-based navigation
        switch (role?.toUpperCase()) {
          case 'ADMIN':
            if (mounted) {
              Navigator.pushReplacementNamed(context, Routes.adminLayout);
            }
            break;
          case 'USER':
          case 'PREUSER':
          case 'TRAINEE':
            if (mounted) {
              Navigator.pushReplacementNamed(context, Routes.layoutScreen);
            }
            break;
          case 'COACH':
            if (mounted) {
              Navigator.pushReplacementNamed(context, Routes.layoutCoachScreen);
            }
            break;
          default:
            if (mounted) {
              Navigator.pushReplacementNamed(context, Routes.loginScreen);
            }
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150.h,
              width: 280.w,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                ImageManager.logo,
                width: 298.w,
                height: 152.h,
              ),
            ),
            SizedBox(height: 70.h),
            JumpingDots(
              color: ColorManager.primaryOrangeColor,
              radius: 15.r,
              numberOfDots: 4,
              animationDuration: Duration(milliseconds: 600),
            ),
          ],
        ),
      ),
    );
  }
}
