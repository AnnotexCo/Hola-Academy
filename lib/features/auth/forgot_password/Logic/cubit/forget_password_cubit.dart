import 'package:bloc/bloc.dart';
import 'package:hola_academy/features/auth/forgot_password/Data/Repo/forget_password_repo.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordRepo forgetPasswordRepo;
  ForgetPasswordCubit(this.forgetPasswordRepo) : super(ForgetPasswordInitial());

  forgetpassword(String email) {
      emit(ForgetPasswordLoading());
    try {
      forgetPasswordRepo.forgetPassword(email);
      emit(ForgetPasswordSuccess());
    } catch (e) {
      emit(ForgetPasswordError(errorMessage: e.toString()));
    }
  }
}
