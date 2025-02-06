import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/Admin/home/UI/home_admin_screen.dart';
import 'package:hola_academy/features/classes/classes_screen.dart';
import 'package:hola_academy/features/notifications/notifications_screen.dart';
import 'package:hola_academy/features/profile/UI/profile_screen.dart';


import '../Admin/transactions/admin_transactions_screen.dart';

class LayoutAdminScreen extends StatefulWidget {
  const LayoutAdminScreen({super.key});

  @override
  State<LayoutAdminScreen> createState() => _LayoutAdminScreenState();
}

class _LayoutAdminScreenState extends State<LayoutAdminScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    HomeAdminScreen(),
    AdminTransactionsScreen(),
    ClassesScreen(),
    NotificationsScreen(),
    ProfileScreen(),
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
    if (index == 2) return; // Prevent selection for the floating button
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  Color _selectedColor(int index) {
    return _selectedIndex == index
        ? ColorManager.primaryOrangeColor
        : const Color(0xff6D6D6D);
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
          ImageManager.transactionIcon,
          height: 24.h,
          width: 24.w,
          color: _selectedColor(1),
        ),
        label: 'Transactions',
      ),
      const BottomNavigationBarItem(
        icon: SizedBox.shrink(), // Placeholder for Floating Button
        label: '',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          ImageManager.notification,
          height: 24.h,
          width: 24.w,
          color: _selectedColor(3),
        ),
        label: 'Notifications',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          ImageManager.profile,
          height: 24.h,
          width: 24.w,
          color: _selectedColor(4),
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
          physics: const NeverScrollableScrollPhysics(), // Disable swipe
          children: _screens,
        ),
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          children: [
            BottomNavigationBar(
              backgroundColor: ColorManager.backgroundColor,
              selectedLabelStyle:
                  TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
              unselectedLabelStyle:
                  TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
              items: _navBarItems(),
              selectedItemColor: ColorManager.primaryOrangeColor,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex == 2
                  ? 0
                  : (_selectedIndex > 2 ? _selectedIndex - 1 : _selectedIndex),
              onTap: _onItemTapped,
            ),
            Positioned(
              bottom: 22.h, // Adjust to position correctly
              left: MediaQuery.of(context).size.width / 2 - 30.w,
              child: Container(
                width: 65.w, // Adjust for correct size
                height: 65.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xffffffff).withOpacity(0.4), // Outer glow
                        Color(0xffF09C1F).withOpacity(0.8),
                      ]),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffF09C1F)
                          .withOpacity(0.6), // Soft glow effect
                      blurRadius: 8, // Intensity of glow
                      spreadRadius: 4,
                      offset: Offset(0, 2), // Glow spread
                    ),
                  ],
                ),
                child: FloatingActionButton(
                  splashColor: Colors.orangeAccent,
                  backgroundColor: Color(0xffF09C1F).withOpacity(0.4),
                  // Use gradient from parent
                  elevation: 0, // Avoid default shadow
                  shape: const CircleBorder(),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 2; // Navigate to "Classes"
                    });
                    _pageController.jumpToPage(2);
                  },
                  child: SvgPicture.asset(
                    ImageManager.scanQricon,
                    height: 35.h,
                    width: 35.w,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
