import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hola_academy/core/local_db/save_token.dart';
import 'package:hola_academy/features/profile/Data/Model/update_user_model.dart';
import 'package:hola_academy/features/profile/Data/Model/user_model.dart';
import 'package:hola_academy/features/profile/Data/Repo/user_repo.dart';
import 'package:image_picker/image_picker.dart';
part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  final UserRepo userRepo;

  UserDataCubit(this.userRepo) : super(UserDataInitial());

  File? profileImage;

   // Function to pick image from gallery
  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
        profileImage = File(pickedFile.path);
    }
  }

  // Function to capture image using the camera
  Future<void> pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
        profileImage = File(pickedFile.path);
    }
  }

  UserModel? userModel;

  Future<void> getMyData() async {
    try {
     if (!isClosed) emit(UserDataLoading());
      final user = await userRepo.getMyData();
      print(user.name);
      print(user.profileImage?.path);
      await SaveTokenDB.saveNameAndImage(user.name, user.profileImage?.path??'');
     if (!isClosed) emit(UserDataSuccess(userModel: user));
    } catch (e) {
      if (!isClosed) emit(UserDataFailure(message: e.toString()));
    }
  }

  Future<void> updateMyData(UpdateUserModel updateUserModel) async {
    try {
     if (!isClosed) emit(UpdateUserDataLoading());
      final isUpdated =
          await userRepo.updateMyData(updateUserModel: updateUserModel);
      if (isUpdated) {
        if (!isClosed) emit(UpdateUserDataSuccess());
        getMyData();
      } else {
      if (!isClosed)  emit(UserDataFailure(message: 'Failed to update user data'));
      }
    } catch (e) {
    if (!isClosed)  emit(UpdateUserDataFailure(message: e.toString()));
    }
  }
}
