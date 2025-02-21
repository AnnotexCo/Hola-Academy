import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hola_academy/core/local_db/save_token.dart';
import 'package:hola_academy/features/personal_info/Data/Model/update_user_model.dart';
import 'package:hola_academy/features/personal_info/Data/Model/user_model.dart';
import 'package:hola_academy/features/personal_info/Data/Repo/user_repo.dart';
part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  final UserRepo userRepo;

  UserDataCubit(this.userRepo) : super(UserDataInitial());

  Future<void> getMyData() async {
    print('Hellooooooooooooooo');
    String? token = await SaveTokenDB.getToken();
    print(token);
    try {
      emit(UserDataLoading());
      final user = await userRepo.getMyData(accessToken: token ?? '');
      print(user);
      emit(UserDataSuccess(userModel: user));
    } catch (e) {
      emit(UserDataFailure(message: e.toString()));
    }
  }

  Future<void> updateMyData(UpdateUserModel updateUserModel) async {
    try {
      emit(UpdateUserDataLoading());
      final isUpdated =
          await userRepo.updateMyData(updateUserModel: updateUserModel);
      if (isUpdated) {
        emit(UpdateUserDataSuccess());
      } else {
        emit(UserDataFailure(message: 'Failed to update user data'));
      }
    } catch (e) {
      emit(UpdateUserDataFailure(message: e.toString()));
    }
  }
}
