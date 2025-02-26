import 'package:hola_academy/core/networking/Dio/User/dio_user_api.dart';
import 'package:hola_academy/features/profile/Data/Model/trainee_model.dart';
import 'package:hola_academy/features/profile/Data/Model/update_user_model.dart';
import '../Model/user_model.dart';

class UserRepo {
  final DioUserApi dioUserApi;

  UserRepo({required this.dioUserApi});

  Future<UserModel> getMyData() async {
    return await dioUserApi.getMyData();
  }

  Future<bool> updateMyData({
    required UpdateUserModel updateUserModel,
  }) async {
    return await dioUserApi.updateMyData(updateUserModel: updateUserModel);
  }

  Future<AllUsersModel> fetchAllUsers() async {
    return await dioUserApi.fetchAllUsers();
  }
}
