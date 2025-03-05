import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/core/dependency_injection/dependency.dart';
import 'package:hola_academy/features/classes/Logic/classes/cubit/classes_cubit.dart';
import 'package:hola_academy/features/classes/Logic/lessons/cubit/lessons_cubit.dart';
import 'package:hola_academy/features/classes/Logic/levels/cubit/levels_cubit.dart';
import 'package:hola_academy/features/classes/Logic/programms/programs_cubit.dart';
import 'package:hola_academy/features/home/UI/home_screen_coach.dart';
import 'package:hola_academy/features/notifications/UI/notifications_screen.dart';
import 'package:hola_academy/features/profile/Logic/personal_info/user_data_cubit.dart';
import 'package:hola_academy/features/schedule_evaluation/UI/schedule_evaluation_screen.dart';
import '../notifications/Logic/notifications_cubit.dart';
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
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIT<ProgramsCubit>(),
        ),
        BlocProvider(
          create: (context) => getIT<LevelsCubit>(),
        ),
        BlocProvider(
          create: (context) => getIT<ClassesCubit>(),
        ),
      ],
      child: HomeScreenCoach(),
    ),
    BlocProvider(
      create: (context) => getIT<LessonsCubit>(),
      child: ScheduleEvaluationScreen(),
    ),
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
      statusBarColor: ColorManager.whiteColor,
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
      return ColorManager.disabledColor;
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
        label: AppString.home,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          ImageManager.scheduleIcon,
          height: 24.h,
          width: 24.w,
          color: _selectedColor(1),
        ),
        label: AppString.schedule,
      ),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            ImageManager.notification,
            height: 24.h,
            width: 24.w,
            color: _selectedColor(2),
          ),
          label: AppString.notifications),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          ImageManager.profile,
          height: 24.h,
          width: 24.w,
          color: _selectedColor(3),
        ),
        label: AppString.profile,
      ),
    ];
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
          unselectedItemColor:
              ColorManager.disabledColor, // Color for unselected items
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
