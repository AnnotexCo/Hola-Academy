import 'package:bloc/bloc.dart';
import 'package:hola_academy/features/auth/verification/Data/Repo/check_otp_repo.dart';
import 'package:meta/meta.dart';

part 'check_otp_state.dart';

class CheckOtpCubit extends Cubit<CheckOtpState> {
  final CheckOtpRepo checkOtpRepo;
  CheckOtpCubit(this.checkOtpRepo) : super(CheckOtpInitial());

  verifyOtp(String email, String otp) async {
    emit(CheckOtpLoading());
    try {
      await checkOtpRepo.checkOtp(email, otp);
      emit(CheckOtpSuccess());
    } catch (e) {
      emit(CheckOtpFailure(message: e.toString()));
    }
  }
}
