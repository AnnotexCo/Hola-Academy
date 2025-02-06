import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';


import 'package:hola_academy/features/home/home_screen_coach.dart';
import 'package:hola_academy/features/notifications/notifications_screen.dart';
import 'package:hola_academy/features/schedule_evaluation/UI/schedule_evaluation_screen.dart';

import '../profile/UI/profile_screen.dart';

class LayoutCoachScreen extends StatefulWidget {
  const LayoutCoachScreen({super.key});

  @override
  State<LayoutCoachScreen> createState() => _LayoutCoachScreenState();
}

class _LayoutCoachScreenState extends State<LayoutCoachScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    HomeScreenCoach(),
    ScheduleEvaluationScreen(),
    NotificationsScreen(),
    ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  void _onItemTapped(int index) {
    // تحقق مما إذا كانت الصفحة الجديدة مجاورة
    if ((index - _selectedIndex).abs() == 1) {
      // إذا كانت مجاورة، استخدم الرسوم المتحركة
      setState(() {
        _selectedIndex = index;
      });
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    } else {
      // إذا كانت بعيدة، انتقل مباشرة
      setState(() {
        _selectedIndex = index;
      });
      _pageController.jumpToPage(index);
    }
  }

  Color _selectedColor(int index) {
    if (_selectedIndex == index) {
      return ColorManager.primaryOrangeColor;
    } else {
      return const Color(0xff6D6D6D);
    }
  }

  List<BottomNavigationBarItem> _navBarItems() {
    return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          ImageManager.home,
          height: 24.h,
          width: 24.w,
          color: _selectedColor(0),
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          ImageManager.scheduleIcon,
          height: 24.h,
          width: 24.w,
          color: _selectedColor(1),
        ),
        label: 'Schedule',
      ),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            ImageManager.notification,
            height: 24.h,
            width: 24.w,
            color: _selectedColor(2),
          ),
          label: 'Notification'),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          ImageManager.profile,
          height: 24.h,
          width: 24.w,
          color: _selectedColor(3),
        ),
        label: 'Profile',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: _screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: ColorManager.backgroundColor,
          selectedLabelStyle:
              TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
          unselectedLabelStyle:
              TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
          items: _navBarItems(),
          selectedItemColor:
              ColorManager.primaryOrangeColor, // Color for selected item
          unselectedItemColor: Colors.grey, // Color for unselected items
          showUnselectedLabels: true, // Show labels for unselected items
          type: BottomNavigationBarType
              .fixed, // Fixed layout for consistent display)
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
