import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/features/onboarding/onbording.dart';
import 'package:hola_academy/features/auth/register/UI/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: false,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hola Academy',
          theme: ThemeData(
            primaryColor: ColorManager.textRedColor,
            colorScheme: ColorScheme.fromSeed(
                seedColor: ColorManager.primaryOrangeColor),
            useMaterial3: true,
          ),
          home: Onbording(),
        );
      },
    );
  }
}
