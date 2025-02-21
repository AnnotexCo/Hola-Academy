import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hola_academy/core/networking/Dio/Auth/dio_check_otp.dart';
import 'package:hola_academy/core/networking/Dio/Auth/dio_forget_password.dart';
import 'package:hola_academy/core/networking/Dio/Auth/dio_reset_password.dart';
import 'package:hola_academy/core/networking/Dio/Auth/dio_sign_up_api.dart';
import 'package:hola_academy/core/networking/Dio/User/dio_user_api.dart';
import 'package:hola_academy/features/auth/forgot_password/Data/Repo/forget_password_repo.dart';
import 'package:hola_academy/features/auth/forgot_password/Logic/cubit/forget_password_cubit.dart';
import 'package:hola_academy/features/auth/login/Data/Repo/login_repo.dart';
import 'package:hola_academy/features/auth/login/Logic/login_cubit.dart';
import 'package:hola_academy/core/networking/Dio/Auth/dio_login_api.dart';
import 'package:hola_academy/features/auth/register/Data/Repo/sign_up_repo.dart';
import 'package:hola_academy/features/auth/register/Logic/sign_up_cubit.dart';
import 'package:hola_academy/features/auth/reset_password/Data/Repo/reset_password_repo.dart';
import 'package:hola_academy/features/auth/reset_password/Logic/cubit/reset_password_cubit.dart';
import 'package:hola_academy/features/auth/verification/Data/Repo/check_otp_repo.dart';
import 'package:hola_academy/features/auth/verification/Logic/cubit/check_otp_cubit.dart';
import 'package:hola_academy/features/personal_info/Data/Repo/user_repo.dart';
import 'package:hola_academy/features/personal_info/Logic/user_data_cubit.dart';

import '../../features/classes/Data/Repo/programs_repo.dart';
import '../../features/classes/Logic/cubit/programs_cubit.dart';
import '../networking/Dio/Program/dio_programs.dart';

final getIT = GetIt.instance; // Ensure it's instance, not calling it

void setUpGetIt() {
  getIT.registerLazySingleton<Dio>(() => Dio());
  // Register Dio
  getIT.registerLazySingleton<DioSignUpApi>(
      () => DioSignUpApi(dio: getIT<Dio>()));

  //SignUp

  getIT.registerLazySingleton<SignUpRepo>(
      () => SignUpRepo(dioSignUpApi: getIT<DioSignUpApi>()));
  getIT.registerFactory<SignUpCubit>(() => SignUpCubit(getIT<SignUpRepo>()));

  // Dio Api's
  // LoginDioApi
  getIT
      .registerLazySingleton<DioLoginApi>(() => DioLoginApi(dio: getIT<Dio>()));
//  ResetPasswordDioApi
  getIT.registerLazySingleton<DioResetPassword>(
      () => DioResetPassword(dio: getIT<Dio>()));
//  ForgetPasswordDioApi
  getIT.registerLazySingleton<DioForgetPassword>(
      () => DioForgetPassword(dio: getIT<Dio>()));
//  CheckOtpDioApi
  getIT
      .registerLazySingleton<DioCheckOTP>(() => DioCheckOTP(dio: getIT<Dio>()));
//  ProgramsDioApi
  getIT
      .registerLazySingleton<DioPrograms>(() => DioPrograms(dio: getIT<Dio>()));
  //Login
  getIT.registerLazySingleton<LoginRepo>(
      () => LoginRepo(dioLoginApi: getIT<DioLoginApi>()));
  getIT.registerFactory<LoginCubit>(() => LoginCubit(getIT<LoginRepo>()));

  //Reset Password
  getIT.registerLazySingleton<ResetPasswordRepo>(
      () => ResetPasswordRepo(dioResetPassword: getIT()));
  getIT.registerFactory<ResetPasswordCubit>(() => ResetPasswordCubit(getIT()));

  //Forget Password
  getIT.registerLazySingleton<ForgetPasswordRepo>(
      () => ForgetPasswordRepo(dioForgetPassword: getIT()));
  getIT
      .registerFactory<ForgetPasswordCubit>(() => ForgetPasswordCubit(getIT()));

  //Check OTP
  getIT.registerLazySingleton<CheckOtpRepo>(
      () => CheckOtpRepo(dioCheckOTP: getIT()));
  getIT.registerFactory<CheckOtpCubit>(() => CheckOtpCubit(getIT()));

  //Programs
  getIT.registerLazySingleton<ProgramsRepo>(() => ProgramsRepo(
        dioPrograms: getIT(),
      ));
  getIT.registerFactory<ProgramsCubit>(() => ProgramsCubit(getIT()));

  //Personal Info
  getIT.registerLazySingleton<DioUserApi>(
      () => DioUserApi(dio: getIT<Dio>()));

   getIT.registerLazySingleton<UserRepo>(() => UserRepo(dioUserApi: getIT<DioUserApi>()));
   getIT.registerFactory<UserDataCubit>(() => UserDataCubit(getIT<UserRepo>()));

}
