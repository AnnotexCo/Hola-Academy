import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/Admin/home/UI/home_admin_screen.dart';
import 'package:hola_academy/features/notifications/notifications_screen.dart';
import 'package:hola_academy/features/profile/UI/profile_screen.dart';
import '../Admin/scanner/qr_code_scanner_screen.dart';
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
        icon: SizedBox.shrink(),
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
          color: _selectedColor(4), // Adjusted for correct selection
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
          physics:
              const NeverScrollableScrollPhysics(), // DEEEEEEE bt5aly el bta3a my3ml4 swap
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
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
            Positioned(
              bottom: 22.h,
              left: MediaQuery.of(context).size.width / 2 - 32.5.w,
              child: Container(
                width: 65.w,
                height: 65.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xffffffff).withValues(alpha: 0.4),
                        Color(0xffF09C1F).withValues(alpha: 0.8),
                      ]),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffF09C1F).withValues(alpha: 0.6),
                      blurRadius: 8,
                      spreadRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: FloatingActionButton(
                  splashColor: Colors.orangeAccent,
                  backgroundColor: Color(0xffF09C1F).withValues(alpha: 0.4),
                  elevation: 0,
                  shape: const CircleBorder(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QRCodeScannerScreen()),
                    );
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
