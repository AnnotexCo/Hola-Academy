import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/features/home/components/timeline_widget.dart';

import '../../../../core/constants/image_manager.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WelcomeWidget(),
                SizedBox(height: 16.h),
                const AdWidget(),
                SizedBox(height: 16.h),
                SizedBox(
                  height: 80.h,
                  width: double.infinity,
                  child: TimelineWidget(),
                ),
                SizedBox(height: 24.h),
                SectionHeader(
                  title: 'New Requests (3)',
                  action: 'View All',
                  onPressed: () {
                    // Navigate to the new requests screen
                    Navigator.of(context).pushNamed(Routes.requestsScreen);
                  },
                ),
                SizedBox(height: 16.h),
                const NewRequestsSection(),
                SizedBox(height: 24.h),
                SectionHeader(
                  title: 'Coaches',
                  action: 'View All',
                  onPressed: () {
                    // Navigate to the new requests screen
                    Navigator.of(context).pushNamed(Routes.traineesScreen);
                  },
                ),
                SizedBox(height: 16.h),
                const CoachesSection(),
                SizedBox(height: 24.h),
                SectionHeader(
                  title: 'Trainee',
                  action: 'View All',
                  onPressed: () {
                    // Navigate to the new requests screen
                    Navigator.of(context).pushNamed(Routes.traineesScreen);
                  },
                ),
                SizedBox(height: 16.h),
                const CoachesSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String? action;
  final Color? color;
  final void Function()? onPressed;

  const SectionHeader({
    super.key,
    required this.title,
    this.action,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: color ?? ColorManager.darkRedColor,
          ),
        ),
        if (action != null && action!.isNotEmpty)
          TextButton(
            onPressed: onPressed,
            child: Text(
              action!,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: color ?? ColorManager.textRedColor,
              ),
            ),
          ),
      ],
    );
  }
}

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left Section: Profile Avatar and Text
        Row(
          children: [
            CircleAvatar(
              radius: 30, // Adjust size to match UI
              backgroundImage: AssetImage(
                'assets/images/profilepic.png', // Replace with actual image URL
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 16, // Adjust size to match UI
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'John Victor',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
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
              size: const Size(
                  100, 100), // Match the size of the circular container
              painter: CurvedBarPainter(),
            ),

            // Circular Statistics Container
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    const Color(0xFFFFF4E2), // Light background for the circle
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'No. Of Trainees : 50',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFF09C1F), // Orange text
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'No. Of Coaches : 10',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFF09C1F), // Orange text
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

class AdWidget extends StatelessWidget {
  const AdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Full width of the parent
      height: 128.h, // Adaptive height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r), // Scaled border radius
        ),
        image: DecorationImage(
          image: AssetImage(ImageManager.addBanner),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Text Section
          Positioned(
            top: 20.h,
            //left: 16.w,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 130.w,
                top: 1.h,
                bottom: 64.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Taste the national dishes of Greek cuisine at',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                      color: ColorManager.whiteColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Mediterranean Delights restaurant.',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                      color: ColorManager.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Button Section
          Positioned(
            bottom: 11.h,
            left: 40.w,

            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA1B237),
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                ),
              ),
              child: Text(
                'View Menu',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewRequestsSection extends StatelessWidget {
  const NewRequestsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (_, __) => SizedBox(height: 16.h),
      itemBuilder: (context, index) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Dot
          Container(
            width: 12.w,
            height: 12.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorManager.primaryOrangeColor,
            ),
          ),
          SizedBox(width: 12.w),
          // Pentagon-shaped Container with Image
          Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(56.w, 56.h),
                painter: PentagonPainter(const Color(0xFFFEF5E9)),
              ),
              ClipOval(
                child: SizedBox(
                  width: 36.w,
                  height: 36.h,
                  child: Image.asset(
                    "assets/images/profilepic.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 12.w),
          // Name and Type
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jumi Ulum',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Private',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Status and Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: ColorManager.primaryOrangeColor.withValues(alpha:  0.1),
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                ),
                child: Text(
                  'Pending',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.primaryOrangeColor,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '02 Jan 2025, 02:00 PM',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Custom Painter for Pentagon Shape
class PentagonPainter extends CustomPainter {
  final Color color;
  PentagonPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path();
    final width = size.width;
    final height = size.height;

    path.moveTo(width * 0.5, 0); // Top point
    path.lineTo(width, height * 0.38); // Top-right
    path.lineTo(width * 0.81, height); // Bottom-right
    path.lineTo(width * 0.19, height); // Bottom-left
    path.lineTo(0, height * 0.38); // Top-left
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CoachesSection extends StatelessWidget {
  const CoachesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 1.4, // Adjusted for better layout proportions
      ),
      itemCount: 2,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFF4E7), // Light orange background
          border: Border.all(
            color: ColorManager.primaryOrangeColor, // Border color
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Circle Avatar
            Center(
              child: CircleAvatar(
                radius: 28.r,
                backgroundImage: AssetImage('assets/images/profilepic.png'),
              ),
            ),
            SizedBox(height: 12.h),
            // Name
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: 'Name: ',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.primaryOrangeColor, // Orange text color
                ),
                children: [
                  TextSpan(
                    text: 'Robert Fox',
                    style: TextStyle(
                      // fontFamily: 'Poppins',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorManager.whiteColor, // Orange text color
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            // Phone Number
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: 'Phone Number: ',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFFA500), // Orange text color
                ),
                children: [
                  TextSpan(
                    text: '01228569715',
                    style: TextStyle(
                      // fontFamily: 'Poppins',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorManager.whiteColor, // Orange text color
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
