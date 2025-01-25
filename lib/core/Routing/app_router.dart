import 'package:flutter/material.dart';
import 'package:hola_academy/features/auth/forgot_password/UI/forgot_password_screen.dart';
import 'package:hola_academy/features/auth/login/UI/login_screen.dart';
import 'package:hola_academy/features/auth/reset_password/UI/reset_password.dart';
import 'package:hola_academy/features/auth/verification/UI/verfication_screen.dart';
import 'package:hola_academy/features/classes/classes_screen.dart';
import 'package:hola_academy/features/classes/detail_class_screen.dart';
import 'package:hola_academy/features/classes/program_levl_screen.dart';
import 'package:hola_academy/features/home/home_screen.dart';
import 'package:hola_academy/features/layout/layout_screen.dart';
import 'package:hola_academy/features/notifications/notifications_screen.dart';
import 'package:hola_academy/features/onboarding/onbording.dart';
import 'package:hola_academy/features/profile/UI/booked_screen.dart';
import 'package:hola_academy/features/profile/UI/contact_us_screen.dart';
import 'package:hola_academy/features/profile/UI/personal_info_screen.dart';
import 'package:hola_academy/features/profile/UI/profile_screen.dart';
import '../../features/Admin/home/UI/home_admin_screen.dart';
import '../../features/Admin/requests/UI/requests_screen.dart';
import '../../features/Admin/trainees/UI/trainees_screen.dart';
import '../../features/analytics/UI/analytics_skills_screen.dart';
import '../../features/auth/register/UI/register_screen.dart';
import '../../features/book/UI/book_programs_screen.dart';
import '../../features/not_found/not_found_screen.dart';
import '../../features/schedule_evaluation/UI/schedule_evaluation_screen.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // home screen
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      //onBoarding
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const Onboarding());
      // register screen
      case Routes.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

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
      // profile
      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      // personal info
      case Routes.personalInfoScreen:
        return MaterialPageRoute(builder: (_) => const PersonalInfoScreen());

      // contact us
      case Routes.contactUsScreen:
        return MaterialPageRoute(builder: (_) => ContactUsScreen());

      // Booked
      case Routes.bookedScreen:
        return MaterialPageRoute(builder: (_) => const BookedScreen());

      // classes
      case Routes.classesScreen:
        return MaterialPageRoute(builder: (_) => ClassesScreen());

      case Routes.detailsScreen:
        return MaterialPageRoute(builder: (_) => DetailClassScreen());

      case Routes.programlevlScreen:
        return MaterialPageRoute(builder: (_) => ProgramLevlScreen());
      // schedule evaluation
      case Routes.scheduleEvaluationScreen:
        return MaterialPageRoute(
            builder: (_) => const ScheduleEvaluationScreen());

      // book programs
      case Routes.bookProgramsScreen:
        return MaterialPageRoute(builder: (_) => const BookProgramScreen());

      // analytics
      case Routes.analyticsSkillsScreen:
        return MaterialPageRoute(builder: (_) => const AnalyticsSkillsScreen());

      // not found
      case Routes.notFoundScreen:
        return MaterialPageRoute(builder: (_) => const NotFoundScreen());
      case Routes.notificationsScreen:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());

      // Admin
      case Routes.homeAdminScreen:
        return MaterialPageRoute(builder: (_) => const HomeAdminScreen());

      case Routes.requestsScreen:
        return MaterialPageRoute(builder: (_) => RequestsScreen());

      case Routes.traineesScreen:
        return MaterialPageRoute(builder: (_) => const TraineesScreen());

      default:
        return null;
    }
  }
}
