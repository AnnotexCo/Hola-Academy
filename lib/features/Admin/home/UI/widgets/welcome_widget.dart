import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/color_manager.dart';
import '../../../../home/UI/components/profile_pic_widget.dart';
import '../../../../profile/Logic/personal_info/user_data_cubit.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        String name = " ";
        String pic = '';

        if (state is UserDataSuccess) {
          name = state.userModel.name;
          pic = state.userModel.profileImage?.path ?? '';
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Section: Profile Avatar and Text
            Row(
              children: [
                ProfilePicWidget(
                  height: 60,
                  width: 60,
                  pic: pic,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),

            // Right Section: Circular Statistics with Curved Bar
            Stack(
              alignment: Alignment.center,
              children: [
                // Semi-circular Orange Bar
                CustomPaint(
                  size: const Size(100, 100),
                  painter: CurvedBarPainter(),
                ),

                // Circular Statistics Container
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFFF4E2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'No. Of Trainees : 50',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFF09C1F),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'No. Of Coaches : 10',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFF09C1F),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

// Custom Painter for the Orange Curved Bar
class CurvedBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = ColorManager.primaryOrangeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6; // Adjust the thickness of the bar

    final Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );

    // Draw the semi-circle (adjust the sweep angle for better positioning)
    canvas.drawArc(
      rect,
      3.14, // Start angle (180 degrees)
      3.14, // Sweep angle (180 degrees)
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}