import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hola_academy/core/local_db/save_token.dart';
import 'package:hola_academy/features/auth/register/Data/Model/sign_up_model.dart';
import 'package:hola_academy/features/auth/register/Data/Repo/sign_up_repo.dart';
import 'package:hola_academy/features/personal_info/Data/Model/user_model.dart';
import 'package:hola_academy/features/personal_info/Data/Repo/user_repo.dart';
part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  final UserRepo userRepo;

  UserDataCubit(this.userRepo) : super(UserDataInitial());

  Future<void> doSignUp(SignUpModel signUpModel) async {
    try {
      emit(UserDataLoading());
      final user = await userRepo.getMyData();
      emit(UserDataSuccess(userModel: user));
    } catch (e) {
      emit(UserDataFailure(message: e.toString()));
    }
  }
}
