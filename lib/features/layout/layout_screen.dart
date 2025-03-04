import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/classes/Logic/categories/categories_cubit.dart';
import 'package:hola_academy/features/classes/Logic/classes/cubit/classes_cubit.dart';
import 'package:hola_academy/features/classes/Logic/lessons/cubit/lessons_cubit.dart';
import 'package:hola_academy/features/classes/UI/classes_screen.dart';
import 'package:hola_academy/features/home/Logic/banner_logic/banner_cubit.dart';
import 'package:hola_academy/features/home/UI/home_screen.dart';
import 'package:hola_academy/features/notifications/UI/notifications_screen.dart';
import 'package:hola_academy/features/profile/Logic/personal_info/user_data_cubit.dart';

import '../../core/dependency_injection/dependency.dart';
import '../classes/Logic/programms/programs_cubit.dart';
import '../notifications/Logic/notifications_cubit.dart';
import '../profile/UI/profile_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIT<UserDataCubit>()..getMyData()),
        BlocProvider(
            create: (context) => getIT<BannersCubit>()..fetchAllBanners()),
        BlocProvider(
            create: (context) => getIT<LessonsCubit>()..getNextLessons()),
      ],
      child: HomeScreen(),
    ),
    MultiBlocProvider(providers: [
      BlocProvider(create: (context) => getIT<ProgramsCubit>()),
      BlocProvider(create: (context) => getIT<CategoriesCubit>()),
      BlocProvider(create: (context) => getIT<ClassesCubit>()),
    ], child: ClassesScreen()),
    BlocProvider(
      create: (context) => getIT<NotificationsCubit>(),
      child: NotificationsScreen(),
    ),
    BlocProvider(
      create: (context) => getIT<UserDataCubit>(),
      child: ProfileScreen(),
    ),
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
          ImageManager.classesIcon,
          height: 24.h,
          width: 24.w,
          color: _selectedColor(1),
        ),
        label: 'Clasess',
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
          physics: const NeverScrollableScrollPhysics(),
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
