import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/components/custom_app_button.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/features/auth/register/UI/register_screen.dart';
import 'package:hola_academy/features/home/home_screen.dart';

import 'content_model.dart';

class Onbording extends StatefulWidget {
  const Onbording({super.key});

  @override
  OnbordingState createState() => OnbordingState();
}

class OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: contents.length,
        onPageChanged: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (_, i) {
          return Stack(
            children: [
              Image.asset(
                height: screenHeight,
                width: screenWidth,
                contents[i].image!,
                fit: BoxFit.fill,
              ),
              SizedBox(height: screenHeight * 0.02),
              Positioned(
                top: currentIndex != contents.length - 1 ? 666.h : 607.h,
                left: 30.w,
                right: 30.w,
                child: Text(
                  contents[i].title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24.sp,
                    color: ColorManager.whiteColor,
                  ),
                ),
              ),
              Positioned(
                top: currentIndex != contents.length - 1 ? 710.h : 652.h,
                left: 30.w,
                right: 30.w,
                child: Text(
                  contents[i].discription!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: ColorManager.whiteColor,
                  ),
                ),
              ),
              Positioned(
                top: currentIndex != contents.length - 1 ? 787.h : 735.h,
                left: 173.w,
                right: 173.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    contents.length,
                    (index) => buildDot(index, context),
                  ),
                ),
              ),
              currentIndex != contents.length - 1
                  ? Positioned(
                      top: 810.h,
                      left: 45.w,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return const HomeScreen();
                          }));
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
                    )
                  : Positioned(
                      top: 780.h,
                      left: 72.w,
                      right: 68.w,
                      child: SizedBox(
                        height: 50.h,
                        width: 300.w,
                        child: CustomAppButton(
                            text: "Create Account",
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return const RegisterScreen();
                              },));
                            }),
                      )),
              currentIndex != contents.length - 1
                  ? Positioned(
                      top: 810.h,
                      right: 45.w,
                      child: GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
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
                    )
                  : Positioned(
                      top: 835.h,
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
                                    decorationColor: ColorManager.whiteColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.whiteColor,
                                    decorationThickness: 2.0,
                                  ),
                                ),
                              ],
                            ),
                          )))
            ],
          );
        },
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 10.h,
      width: currentIndex == index ? 40.w : 10.w,
      margin: EdgeInsets.only(right: screenWidth * 0.012),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: currentIndex == index
            ? ColorManager.whiteColor
            : ColorManager.whiteColor.withValues(alpha: 0.8),
      ),
    );
  }
}
