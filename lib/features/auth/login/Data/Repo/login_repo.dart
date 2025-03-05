import '../../../../../core/local_db/save_token.dart';
import '../../../../../core/networking/Dio/Auth/dio_login_api.dart';
import '../Model/login_model.dart';

class LoginRepo {
  final DioLoginApi dioLoginApi;

  LoginRepo({required this.dioLoginApi});

  Future<bool> doLogin({required LoginModel loginModel, required String fcmtoken}) async {
    return await dioLoginApi.dioLogin(loginModel: loginModel, fcmtoken: fcmtoken);
  }

  /// Fetch saved role
  Future<String?> getUserRole() async {
    return await SaveTokenDB.getRole();
  }

  Future<bool> doGoogleLogin({required String accessToken, required String fcmtoken}) async {
    return await dioLoginApi.dioGoogleLogin(accessToken: accessToken, fcmtoken: fcmtoken);
  }


  Future<bool> doLogout({required String fcmtoken}) async {
    return await dioLoginApi.dioLogout(fcmtoken: fcmtoken);
  }
}
