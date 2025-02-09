import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hola_academy/core/local_db/save_token.dart';
import '../Data/Model/login_model.dart';
import '../Data/Repo/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;

  LoginCubit(this.loginRepo) : super(LoginInitial());

  Future<void> doLogin(LoginModel loginModel) async {
    emit(LoginLoading());
    try {
      bool isSuccess = await loginRepo.doLogin(loginModel: loginModel);
      if (isSuccess) {
        String? token = await SaveTokenDB.getToken();
        String? role = await SaveTokenDB.getRole(); // Retrieve role

        if (token != null && role != null) {
          emit(LoginSuccess(role: role));  // Pass role to UI
        } else {
          emit(LoginFailure(message: "Token or Role not found"));
        }
      } else {
        emit(LoginFailure(message: "Invalid login credentials"));
      }
    } catch (e) {
      emit(LoginFailure(message: e.toString()));
    }
  }

  Future<void> logout() async {
    await SaveTokenDB.deleteTokenAndRole(); // Clear both token & role
    emit(LoginInitial());
  }
}
