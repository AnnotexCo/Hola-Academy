import 'package:firebase_messaging/firebase_messaging.dart';
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
   if (!isClosed) emit(LoginLoading());
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken == null) {
        if (!isClosed) emit(LoginFailure(message: "Failed to get FCM Token"));
        return;
      }
      bool isSuccess =
          await loginRepo.doLogin(loginModel: loginModel, fcmToken: fcmToken);
      if (isSuccess) {
        String? token = await SaveTokenDB.getToken();
        String? role = await SaveTokenDB.getRole();
        // print(token);
        if (token != null && role != null) {
          if (!isClosed) emit(LoginSuccess(role: role, token: token));
        } else {
          if (!isClosed) emit(LoginFailure(message: "Token or Role not found"));
        }
      } else {
        if (!isClosed) emit(LoginFailure(message: "Invalid login credentials"));
      }
    } catch (e) {
      if (!isClosed) emit(LoginFailure(message: e.toString()));
    }
  }

  Future<void> doGoogleLogin() async {
    if (!isClosed) emit(LoginLoading());

    try {
      final GoogleSignIn googleLogin = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleLogin.signIn();

      if (googleUser == null) {
        if (!isClosed) emit(LoginFailure(message: "Google sign-in was canceled"));
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? accessToken = googleAuth.accessToken;

      if (accessToken == null) {
        if (!isClosed) emit(LoginFailure(message: "Google Access Token not found"));
        return;
      }
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken == null) {
        if (!isClosed) emit(LoginFailure(message: "Failed to get FCM Token"));
        return;
      }

      bool isSuccess = await loginRepo.doGoogleLogin(
          accessToken: accessToken, fcmToken: fcmToken);

      if (isSuccess) {
        String? token = await SaveTokenDB.getToken();
        String? role = await SaveTokenDB.getRole(); // Get the saved role

        if (token != null && role != null) {
          if (!isClosed) emit(LoginSuccess(role: role, token: token));
        } else {
          if (!isClosed) emit(LoginFailure(message: "Role or Token not found after Google login"));
        }
      } else {
        if (!isClosed) emit(LoginFailure(message: "Google login failed"));
      }
    } catch (e) {
      if (!isClosed) emit(LoginFailure(message: e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken == null) {
        if (!isClosed) emit(LoginFailure(message: "Failed to get FCM Token"));
        return;
      }

      bool isLoggedOut = await loginRepo.doLogout(fcmToken: fcmToken);

      if (isLoggedOut) {
        await SaveTokenDB.deleteTokenAndRole();
        if (!isClosed) emit(LoginInitial());
      } else {
        if (!isClosed) emit(LoginFailure(message: "Logout failed"));
      }
    } catch (e) {
      if (!isClosed) emit(LoginFailure(message: e.toString()));
    }
  }
}
