import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/components/custom_app_button.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/features/auth/register/UI/register_screen.dart';

import 'content_model.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  OnboardingState createState() => OnboardingState();
}

class OnboardingState extends State<Onboarding> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Pre-cache images to avoid flashing
    for (var content in contents) {
      if (content.image != null) {
        precacheImage(AssetImage(content.image!), context);
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: contents.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double pageOffset = 0.0;
                  if (_pageController.position.haveDimensions) {
                    pageOffset = _pageController.page! - index;
                  }

                  // Smooth transition effect
                  final opacity = (1 - pageOffset.abs()).clamp(0.0, 1.0);
                  final translateX = pageOffset * screenWidth;

                  return Transform.translate(
                    offset: Offset(translateX, 0),
                    child: Opacity(
                      opacity: opacity,
                      child: Stack(
                        children: [
                          // Background Image
                          Image.asset(
                            contents[index].image!,
                            height: screenHeight,
                            width: screenWidth,
                            fit: BoxFit.cover,
                          ),

                          // Title
                          Positioned(
                            top: 640.h,
                            left: 30.w,
                            right: 30.w,
                            child: Text(
                              contents[index].title!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 24.sp,
                                color: ColorManager.whiteColor,
                              ),
                            ),
                          ),

                          // Description
                          Positioned(
                            top: 690.h,
                            left: 30.w,
                            right: 30.w,
                            child: Text(
                              contents[index].discription!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: ColorManager.whiteColor,
                              ),
                            ),
                          ),

                          // Dots indicator
                          Positioned(
                            top: 787.h,
                            left: 173.w,
                            right: 173.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                contents.length,
                                (dotIndex) => buildDot(dotIndex),
                              ),
                            ),
                          ),

                          // Skip button
                          if (index != contents.length - 1)
                            Positioned(
                              top: 846.h,
                              left: 45.w,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.layoutScreen);
                                },
                                child: Text(
                                  "Skip",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: ColorManager.backgroundColor,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),

                          // Create Account button
                          if (index == contents.length - 1)
                            Positioned(
                              top: 835.h,
                              left: 72.w,
                              right: 68.w,
                              child: SizedBox(
                                height: 50.h,
                                width: 300.w,
                                child: CustomAppButton(
                                  text: "Create Account",
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return RegisterScreen();
                                      },
                                    ));
                                  },
                                ),
                              ),
                            ),

                          // Next button
                          if (index != contents.length - 1)
                            Positioned(
                              top: 864.h,
                              right: 45.w,
                              child: GestureDetector(
                                onTap: () {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: ColorManager.backgroundColor,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),

                          // Login link
                          if (index == contents.length - 1)
                            Positioned(
                              top: 892.h,
                              left: 108.w,
                              right: 103.w,
                              child: SizedBox(
                                height: 50.h,
                                width: 300.w,
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Already have an account? ",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: ColorManager.whiteColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Login",
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.whiteColor,
                                          decorationThickness: 2.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      height: 10.h,
      width: _currentPage == index ? 40.w : 10.w,
      margin: EdgeInsets.only(right: 8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: _currentPage == index
            ? ColorManager.whiteColor
            : ColorManager.whiteColor.withValues(alpha: 0.8),
      ),
    );
  }
}
