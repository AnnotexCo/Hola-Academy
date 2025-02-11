import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hola_academy/features/auth/login/Data/Repo/login_repo.dart';
import 'package:hola_academy/features/auth/login/Logic/login_cubit.dart';
import 'package:hola_academy/core/networking/Dio/Auth/dio_login_api.dart';

final getIT = GetIt.instance; // Ensure it's instance, not calling it

void setUpGetIt() {
  // Register Dio
  getIT.registerLazySingleton<Dio>(() => Dio());

  // Register DioLoginApi
  getIT.registerLazySingleton<DioLoginApi>(() => DioLoginApi(dio: getIT<Dio>()));

  // Register LoginRepo
  getIT.registerLazySingleton<LoginRepo>(() => LoginRepo(dioLoginApi: getIT<DioLoginApi>()));

  // Register LoginCubit
  getIT.registerFactory<LoginCubit>(() => LoginCubit(getIT<LoginRepo>()));
}
