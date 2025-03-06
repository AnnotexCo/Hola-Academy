import '../../../../../core/local_db/save_token.dart';
import '../../../../../core/networking/Dio/Auth/dio_login_api.dart';
import '../Model/login_model.dart';

class LoginRepo {
  final DioLoginApi dioLoginApi;

  LoginRepo({required this.dioLoginApi});

  Future<bool> doLogin(
      {required LoginModel loginModel, required String fcmToken}) async {
    return await dioLoginApi.dioLogin(
        loginModel: loginModel, fcmToken: fcmToken);
  }

  /// Fetch saved role
  Future<String?> getUserRole() async {
    return await SaveTokenDB.getRole();
  }

  Future<bool> doGoogleLogin(
      {required String accessToken, required String fcmToken}) async {
    return await dioLoginApi.dioGoogleLogin(
        accessToken: accessToken, fcmToken: fcmToken);
  }

  Future<bool> doLogout({required String fcmToken}) async {
    return await dioLoginApi.dioLogout(fcmToken: fcmToken);
  }
}
