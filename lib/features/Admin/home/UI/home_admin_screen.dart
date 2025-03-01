import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/features/Admin/requests/Logic/requests_cubit.dart';
import 'package:hola_academy/features/home/UI/components/timeline_widget.dart';
import 'package:hola_academy/features/profile/Logic/personal_info/user_data_cubit.dart';

import '../../../../core/dependency_injection/dependency.dart';
import '../../../home/Logic/banner_logic/banner_cubit.dart';
import '../../../home/UI/components/add_baner.dart';
import 'widgets/new_requests_section.dart';
import 'widgets/section_header.dart';
import 'widgets/welcome_widget.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
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
                BlocProvider(
                  create: (context) => getIT<UserDataCubit>()..fetchAllUsers(),
                  child: WelcomeWidget(),
                ),
                SizedBox(height: 16.h),
                BlocProvider(
                  create: (context) => getIT<BannersCubit>()..fetchAllBanners(),
                  child: AddBaner(),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  height: 80.h,
                  width: double.infinity,
                  child: TimelineWidget(),
                ),
                SizedBox(height: 24.h),
                SectionHeader(
                  title: 'New Requests',
                  action: 'View All',
                  onPressed: () {
                    // Navigate to the new requests screen
                    Navigator.of(context).pushNamed(Routes.requestsScreen);
                  },
                ),
                SizedBox(height: 16.h),
                BlocProvider(
                  create: (context) =>
                      getIT<RequestsCubit>()..fetchAllRequests(),
                  child: NewRequestsSection(),
                ),
                SizedBox(height: 24.h),
                SectionHeader(
                  title: 'Coaches',
                  action: 'View All',
                  onPressed: () {
                    // Navigate to the new requests screen
                    Navigator.of(context).pushNamed(Routes.traineesScreen, arguments: 'COACH');
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
                    Navigator.of(context).pushNamed(Routes.traineesScreen, arguments: 'TRAINEE');
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
        childAspectRatio: 1.2, // Adjusted for better layout proportions
      ),
      itemCount: 2,
      itemBuilder: (context, index) => Container(
        width: 194.w,
        height: 126.h,
        decoration: BoxDecoration(
          color: ColorManager.lightYellow, // Light orange background
          border: Border.all(
            color: ColorManager.primaryOrangeColor, // Border color
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.only(left: 7.w),
        child: Column(
          spacing: 8.h,
          mainAxisAlignment: MainAxisAlignment.center,
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
