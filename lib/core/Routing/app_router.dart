import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hola_academy/core/dependency_injection/dependency.dart';
import 'package:hola_academy/features/admin/transactions/admin_transactions_screen.dart';
import 'package:hola_academy/features/auth/forgot_password/Logic/cubit/forget_password_cubit.dart';
import 'package:hola_academy/features/auth/forgot_password/UI/forgot_password_screen.dart';
import 'package:hola_academy/features/auth/login/UI/login_screen.dart';
import 'package:hola_academy/features/auth/logout/logout_screen.dart';
import 'package:hola_academy/features/auth/reset_password/Logic/cubit/reset_password_cubit.dart';
import 'package:hola_academy/features/auth/reset_password/UI/reset_password.dart';
import 'package:hola_academy/features/auth/verification/UI/verfication_screen.dart';
import 'package:hola_academy/features/classes/UI/classes_screen.dart';
import 'package:hola_academy/features/classes/UI/detail_class_screen.dart';
import 'package:hola_academy/features/classes/UI/program_levl_screen.dart';
import 'package:hola_academy/features/home/components_coach/find_trainees_screen.dart';
import 'package:hola_academy/features/home/home_screen.dart';
import 'package:hola_academy/features/home/home_screen_coach.dart';
import 'package:hola_academy/features/layout/layout_admin_screen.dart';
import 'package:hola_academy/features/layout/layout_coach.dart';
import 'package:hola_academy/features/layout/layout_screen.dart';
import 'package:hola_academy/features/notifications/notifications_screen.dart';
import 'package:hola_academy/features/onboarding/onbording.dart';
import 'package:hola_academy/features/profile/UI/booked_screen.dart';
import 'package:hola_academy/features/profile/UI/contact_us_screen.dart';
import 'package:hola_academy/features/profile/UI/personal_info_screen.dart';
import 'package:hola_academy/features/profile/UI/profile_screen.dart';
import 'package:hola_academy/features/splash/splash_screen.dart';
import '../../features/Admin/home/UI/home_admin_screen.dart';
import '../../features/Admin/requests/UI/requests_screen.dart';
import '../../features/Admin/trainees/UI/trainees_screen.dart';
import '../../features/analytics/UI/analytics_skills_screen.dart';
import '../../features/auth/login/Logic/login_cubit.dart';
import '../../features/auth/register/UI/register_screen.dart';
import '../../features/book/UI/book_programs_screen.dart';
import '../../features/classes/Logic/cubit/programs_cubit.dart';
import '../../features/not_found/not_found_screen.dart';
import '../../features/profile/UI/request_payment_screen.dart';
import '../../features/schedule_evaluation/UI/schedule_evaluation_screen.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // home screen
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      // home screen
      case Routes.homeScreenCoach:
        return MaterialPageRoute(builder: (_) => const HomeScreenCoach());

      //onBoarding
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const Onboarding());
      // register screen
      case Routes.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      // Login Screen
      case Routes.loginScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIT<LoginCubit>(),
                  child: const LoginScreen(),
                ));

      // forgot password
      case Routes.forgotPassword:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIT<ForgetPasswordCubit>(),
                  child: const ForgotPasswordScreen(),
                ));

      // reset password
      case Routes.resetPassword:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIT<ResetPasswordCubit>(),
                  child: const ResetPassword(),
                ));

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

      //  Request payment
      case Routes.requestPaymentScreen:
        return MaterialPageRoute(builder: (_) => const RequestPaymentScreen());

      // classes
      case Routes.classesScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIT<ProgramsCubit>(),
                  child: ClassesScreen(),
                ));

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
      case Routes.adminLayout:
        return MaterialPageRoute(builder: (_) => const LayoutAdminScreen());
      case Routes.homeAdminScreen:
        return MaterialPageRoute(builder: (_) => const HomeAdminScreen());

      case Routes.requestsScreen:
        return MaterialPageRoute(builder: (_) => RequestsScreen());

      case Routes.traineesScreen:
        return MaterialPageRoute(builder: (_) => const TraineesScreen());

      case Routes.adminTransactionsScreen:
        return MaterialPageRoute(builder: (_) => AdminTransactionsScreen());

      case Routes.findTraineeScreen:
        return MaterialPageRoute(builder: (_) => const FindTraineesScreen());

      // coach
      case Routes.layoutCoachScreen:
        return MaterialPageRoute(builder: (_) => const LayoutCoachScreen());

      //case Routes.adminQrCodeScannerScreen:
      //return MaterialPageRoute(builder: (_) => const QRCodeScannerScreen());
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.logoutScreen:
        return MaterialPageRoute(builder: (_) => const LogoutScreen());

      default:
        return null;
    }
  }
}
