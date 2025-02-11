import '../../../../../core/local_db/save_token.dart';
import '../../../../../core/networking/Dio/dio_login_api.dart';
import '../Model/login_model.dart';

class LoginRepo {
  final DioLoginApi dioLoginApi;

  LoginRepo({required this.dioLoginApi});

  Future<bool> doLogin({required LoginModel loginModel}) async {
    return await dioLoginApi.dioLogin(loginModel: loginModel);
  }

  /// Fetch saved role
  Future<String?> getUserRole() async {
    return await SaveTokenDB.getRole();
  }

  Future<bool> doGoogleLogin({required String accessToken}) async {
    print('Access Tooken: $accessToken');
    return await dioLoginApi.dioGoogleLogin(accessToken: accessToken);
  }
}
