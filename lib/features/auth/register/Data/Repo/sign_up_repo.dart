import 'package:hola_academy/core/networking/Dio/Auth/dio_sign_up_api.dart';
import '../Model/sign_up_model.dart';

class SignUpRepo {
  final DioSignUpApi dioSignUpApi;

  SignUpRepo({required this.dioSignUpApi});

  Future<bool>signUp({required SignUpModel signUpModel}) async {
    return await dioSignUpApi.dioSignUp(signUpModel: signUpModel);
  }
}
