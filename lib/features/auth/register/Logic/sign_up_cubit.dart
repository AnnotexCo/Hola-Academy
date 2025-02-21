import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hola_academy/features/auth/register/Data/Model/sign_up_model.dart';
import 'package:hola_academy/features/auth/register/Data/Repo/sign_up_repo.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepo signUpRepo;

  SignUpCubit(this.signUpRepo) : super(SignUpInitial());

  Future<void> doSignUp(SignUpModel signUpModel) async {
    try {
      emit(SignUpLoading());
      await signUpRepo.signUp(signUpModel: signUpModel);
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFailure(message: e.toString()));
    }
  }
}
