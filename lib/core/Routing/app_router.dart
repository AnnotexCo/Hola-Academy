import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hola_academy/core/dependency_injection/dependency.dart';
import 'package:hola_academy/features/Admin/transactions/admin_transactions_screen.dart';
import 'package:hola_academy/features/auth/forgot_password/Logic/cubit/forget_password_cubit.dart';
import 'package:hola_academy/features/auth/forgot_password/UI/forgot_password_screen.dart';
import 'package:hola_academy/features/auth/login/UI/login_screen.dart';
import 'package:hola_academy/features/auth/logout/logout_screen.dart';
import 'package:hola_academy/features/auth/register/Logic/sign_up_cubit.dart';
import 'package:hola_academy/features/auth/reset_password/Logic/cubit/reset_password_cubit.dart';
import 'package:hola_academy/features/auth/reset_password/UI/reset_password.dart';
import 'package:hola_academy/features/auth/verification/Data/Model/reset_args.dart';
import 'package:hola_academy/features/auth/verification/Logic/cubit/check_otp_cubit.dart';
import 'package:hola_academy/features/auth/verification/UI/verfication_screen.dart';
import 'package:hola_academy/features/classes/Logic/categories/categories_cubit.dart';
import 'package:hola_academy/features/classes/UI/classes_screen.dart';
import 'package:hola_academy/features/classes/UI/detail_class_screen.dart';
import 'package:hola_academy/features/classes/UI/program_levl_screen.dart';
import 'package:hola_academy/features/home/UI/components_coach/find_trainees_screen.dart';
import 'package:hola_academy/features/home/UI/home_screen.dart';
import 'package:hola_academy/features/home/UI/home_screen_coach.dart';
import 'package:hola_academy/features/layout/layout_admin_screen.dart';
import 'package:hola_academy/features/layout/layout_coach.dart';
import 'package:hola_academy/features/layout/layout_screen.dart';
import 'package:hola_academy/features/notifications/notifications_screen.dart';
import 'package:hola_academy/features/onboarding/onbording.dart';
import 'package:hola_academy/features/profile/Logic/personal_info/user_data_cubit.dart';
import 'package:hola_academy/features/profile/UI/personal_info_screen.dart';
import 'package:hola_academy/features/profile/UI/booked_screen.dart';
import 'package:hola_academy/features/profile/UI/contact_us_screen.dart';
import 'package:hola_academy/features/profile/UI/profile_screen.dart';
import 'package:hola_academy/features/splash/splash_screen.dart';
import '../../features/Admin/home/UI/home_admin_screen.dart';
import '../../features/Admin/requests/Logic/requests_cubit.dart';
import '../../features/Admin/requests/UI/requests_screen.dart';
import '../../features/Admin/trainees/UI/trainees_screen.dart';
import '../../features/analytics/UI/analytics_skills_screen.dart';
import '../../features/auth/login/Logic/login_cubit.dart';
import '../../features/auth/register/UI/register_screen.dart';
import '../../features/book/UI/book_programs_screen.dart';
import '../../features/classes/Data/Model/programs_model.dart';
import '../../features/classes/Logic/programms/programs_cubit.dart';
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
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIT<SignUpCubit>(),
                  child: const RegisterScreen(),
                ));

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
        return MaterialPageRoute(builder: (context) {
          final args = settings.arguments as ResetPasswordArgs;

          return BlocProvider(
            create: (context) => getIT<ResetPasswordCubit>(),
            child: ResetPassword(
              email: args.email,
              otp: args.otp,
            ),
          );
        });

      // verification
      case Routes.verificationScreen:
        return MaterialPageRoute(builder: (contex) {
          final String email = settings.arguments as String; // Get phone number
          return BlocProvider(
            create: (context) => getIT<CheckOtpCubit>(),
            child: VerificationScreen(
              email: email,
            ),
          );
        });
      case Routes.layoutScreen:
        return MaterialPageRoute(builder: (_) => const LayoutScreen());
      // profile
      case Routes.profileScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIT<UserDataCubit>(),
                  child: const ProfileScreen(),
                ));

      // personal info
      case Routes.personalInfoScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIT<UserDataCubit>(),
                  child: PersonalInfoScreen(),
                ));

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
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => getIT<ProgramsCubit>()),
                BlocProvider(create: (context) => getIT<CategoriesCubit>()),
              ],
               child: ClassesScreen())           
        );
        
      case Routes.detailsScreen:
        return MaterialPageRoute(
          builder: (context) {
            final int programId = settings.arguments as int; // Get ID
            return BlocProvider(
              create: (context) =>
                  getIT<ProgramsCubit>()..fetchProgramById(programId),
              child: DetailClassScreen(programId: programId), // Pass to screen
            );
          },
        );

      case Routes.programlevlScreen:
        return MaterialPageRoute(
          builder: (context) {
            final LevelModel level = settings.arguments as LevelModel;
            return ProgramLevlScreen(level: level);
          },
        );
      // schedule evaluation
      case Routes.scheduleEvaluationScreen:
        return MaterialPageRoute(
            builder: (_) => const ScheduleEvaluationScreen());

      // book programs
      case Routes.bookProgramsScreen:
        return MaterialPageRoute(
            builder: (_) {
              final int programId = settings.arguments as int;
              return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => getIT<RequestsCubit>()),
                BlocProvider(create: (context) => getIT<UserDataCubit>()),
              ],
              child: BookProgramScreen(programId: programId),
            );
            });

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
  return MaterialPageRoute(
    builder: (_) => MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIT<RequestsCubit>()),
        BlocProvider(create: (context) => getIT<UserDataCubit>()),
      ],
      child: RequestsScreen(),
    ),
  );

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
