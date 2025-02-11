import 'package:bloc/bloc.dart';
import 'package:hola_academy/features/auth/reset_password/Data/Repo/reset_password_repo.dart';
import 'package:meta/meta.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordRepo resetPasswordRepo;
  ResetPasswordCubit(this.resetPasswordRepo) : super(ResetPasswordInitial());

  resetPassword(
    String email,
    String newpassword,
    int otp,
  ) {
      emit(ResetPasswordLoading());
    try {
      resetPasswordRepo.resetPassword(email, newpassword, otp);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordFailure(error: e.toString()));
    }
  }
}
