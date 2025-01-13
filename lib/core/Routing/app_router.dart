import 'package:flutter/material.dart';
import 'package:hola_academy/features/auth/forgot_password/UI/forgot_password_screen.dart';
import 'package:hola_academy/features/auth/login/UI/login_screen.dart';
import 'package:hola_academy/features/auth/reset_password/UI/reset_password.dart';
import 'package:hola_academy/features/auth/verification/UI/verfication_screen.dart';
import 'package:hola_academy/features/home/home_screen.dart';
import 'package:hola_academy/features/layout/layout_screen.dart';

import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // home screen
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      // Login Screen
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      // forgot password
      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      // reset password
      case Routes.resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPassword());

      // verification
      case Routes.verificationScreen:
        return MaterialPageRoute(builder: (_) => const VerificationScreen());
      case Routes.layoutScreen:
        return MaterialPageRoute(builder: (_) => const LayoutScreen());

      default:
        return null;
    }
  }
}
