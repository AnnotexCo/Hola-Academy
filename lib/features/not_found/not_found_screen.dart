import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotFoundScreen extends StatelessWidget {
  final String? svgPath; // Path to the SVG image
  final String defaultSvgPath = 'assets/images/not_found.svg'; // Default SVG

  const NotFoundScreen({this.svgPath, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 317.h), 
              Opacity(
                opacity: 1.0, 
                child: SvgPicture.asset(
                  svgPath ?? defaultSvgPath, 
                  width: 384.w, 
                  height: 343.h, 
                  placeholderBuilder: (context) =>
                      const CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
