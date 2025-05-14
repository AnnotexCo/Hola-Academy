import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/core/dependency_injection/dependency.dart';
import 'package:hola_academy/features/Admin/home/UI/home_admin_screen.dart';
import 'package:hola_academy/features/Admin/scanner/Logic/attendance_cubit.dart';
import 'package:hola_academy/features/notifications/UI/notifications_screen.dart';
import 'package:hola_academy/features/profile/Logic/personal_info/user_data_cubit.dart';
import 'package:hola_academy/features/profile/Logic/transactions/trans_cubit.dart';
import 'package:hola_academy/features/profile/UI/personal_info_screen.dart';
import '../Admin/scanner/UI/qr_code_scanner_screen.dart';
import '../Admin/transactions/admin_transactions_screen.dart';
import '../notifications/Logic/notifications_cubit.dart';

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
    BlocProvider(
        create: (context) => getIT<TransCubit>(),
        child: AdminTransactionsScreen()),
    BlocProvider(
      create: (context) => getIT<AttendanceCubit>(),
      child: QRCodeScannerScreen(),
    ),
    BlocProvider(
      create: (context) => getIT<NotificationsCubit>(),
      child: NotificationsScreen(),
    ),
    BlocProvider(
      create: (context) => getIT<UserDataCubit>()..getMyData(),
      child: PersonalInfoScreen(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ColorManager.whiteColor,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  void _onItemTapped(int index) {
    if (index == 2) return; // Prevent selection for the floating button
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  Color _selectedColor(int index) {
    return _selectedIndex == index
        ? ColorManager.primaryOrangeColor
        : ColorManager.linearGradient3;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: ColorManager.whiteColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: ColorManager.whiteColor,
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
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
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    ImageManager.home,
                    height: 24.h,
                    width: 24.w,
                    colorFilter: ColorFilter.mode(
                      _selectedColor(0),
                      BlendMode.srcIn,
                    ),
                  ),
                  label: AppString.home,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    ImageManager.transactionIcon,
                    height: 24.h,
                    width: 24.w,
                    colorFilter: ColorFilter.mode(
                      _selectedColor(1),
                      BlendMode.srcIn,
                    ),
                  ),
                  label: AppString.transactions,
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
                    colorFilter: ColorFilter.mode(
                      _selectedColor(3),
                      BlendMode.srcIn,
                    ),
                  ),
                  label: AppString.notifications,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    ImageManager.profile,
                    height: 24.h,
                    width: 24.w,
                    colorFilter: ColorFilter.mode(
                      _selectedColor(4),
                      BlendMode.srcIn,
                    ),
                  ),
                  label: AppString.profile,
                ),
              ],
              selectedItemColor: ColorManager.primaryOrangeColor,
              unselectedItemColor: ColorManager.linearGradient3,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
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
                        ColorManager.whiteColor.withValues(alpha: 0.4),
                        ColorManager.primaryOrangeColor.withValues(alpha: 0.8),
                      ]),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.primaryOrangeColor
                          .withValues(alpha: 0.4),
                      //Color(0xffF09C1F).withValues(alpha: 0.6),
                      blurRadius: 8,
                      spreadRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: FloatingActionButton(
                  splashColor: Colors.orangeAccent,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: const CircleBorder(),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                    _pageController.jumpToPage(2);
                  },
                  child: SvgPicture.asset(
                    ImageManager.scanQrIcon,
                    height: 35.h,
                    width: 35.w,
                    colorFilter: ColorFilter.mode(
                      ColorManager.whiteColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
