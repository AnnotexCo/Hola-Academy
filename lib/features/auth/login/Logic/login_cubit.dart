import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hola_academy/core/local_db/save_token.dart';
import '../Data/Model/login_model.dart';
import '../Data/Repo/login_repo.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
        String? role = await SaveTokenDB.getRole(); 

        if (token != null && role != null) {
          emit(LoginSuccess(role: role));  
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

 Future<void> doGoogleLogin() async {
    emit(LoginLoading());

    try {
      final GoogleSignIn googleLogin = GoogleSignIn();

      final GoogleSignInAccount? googleUser = await googleLogin.signIn();

      if (googleUser == null) {
        emit(LoginFailure(message: "Google sign-in was canceled"));
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final String? accessToken = googleAuth.accessToken;
      if (accessToken == null) {
        emit(LoginFailure(message: "Google Access Token not found"));
        return;
      }

      bool isSuccess = await loginRepo.doGoogleLogin(accessToken: accessToken);

      if (isSuccess) {
        emit(LoginSuccess(role: "TRAINEE"));
      } else {
        emit(LoginFailure(message: "Google login failed"));
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
