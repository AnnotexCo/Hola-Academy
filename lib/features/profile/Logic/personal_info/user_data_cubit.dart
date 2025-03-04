import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hola_academy/features/profile/Data/Model/trainee_model.dart';
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
      emit(PickImageSuccess(profileImage: profileImage!));
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
      userModel = user;
      if (!isClosed) emit(UserDataSuccess(userModel: user));
    } catch (e) {
      if (!isClosed) emit(UserDataFailure(message: e.toString()));
    }
  }

  Future<void> updateMyData(UpdateUserModel updateUserModel) async {
    try {
      print('profileImage: $profileImage');
      if (!isClosed) emit(UpdateUserDataLoading());
      final isUpdated =
          await userRepo.updateMyData(updateUserModel: updateUserModel);
      if (isUpdated) {
        if (!isClosed) emit(UpdateUserDataSuccess());
        await getMyData();
        profileImage = null;
      } else {
        if (!isClosed)
          emit(UserDataFailure(message: 'Failed to update user data'));
      }
    } catch (e) {
      if (!isClosed) emit(UpdateUserDataFailure(message: e.toString()));
    }
  }

  List<User> users = [];
  List<User> filteredUsers = [];
  List<User> trainees = [];
  List<User> coaches = [];
  Future<void> fetchAllUsers() async {
    try {
      if (!isClosed) emit(UserDataLoading());
      final userss = await userRepo.fetchAllUsers();
      users = userss.data.users;
      filteredUsers = users;
      coaches.clear();
      trainees.clear();
      for (var user in users) {
        if (user.role == "COACH") {
          coaches.add(user);
        } else if (user.role == "TRAINEE") {
          trainees.add(user);
        }
      }
      if (!isClosed) emit(FetchAllUsersSuccess(users: userss));
    } catch (e) {
      if (!isClosed) emit(FetchAllUsersFailure(message: e.toString()));
    }
  }

  // Optimized Search Function
  void searchUsers(String query, String role) {
    List<User> source = role == "COACH" ? coaches : trainees;
    if (query.trim().isEmpty) {
      filteredUsers = List.from(source);
    } else {
      final searchQuery = query.toLowerCase();
      filteredUsers = source.where((user) {
        return (user.name?.toLowerCase().contains(searchQuery) ?? false) ||
            (user.phoneNumber?.toLowerCase().contains(searchQuery) ?? false);
      }).toList();
    }
    print(filteredUsers);

    if (!isClosed) emit(FilterUsersSuccess(filteredUsers: filteredUsers));
  }

  Future<void> fetchUsersByRole({String? role}) async {
    try {
      if (!isClosed) emit(UserDataLoading());
      final users = await userRepo.fetchAllUsers(role: role);
      if (!isClosed) emit(FetchUsersByRoleSuccess(users: users));
    } catch (e) {
      if (!isClosed) emit(FetchUsersByRoleFailure(message: e.toString()));
    }
  }

  Future<void> fetchTraineesByID(int classID) async {
    try {
      if (!isClosed) emit(UserDataLoading());
      final users = await userRepo.fetchTraineesByID(classID);
      print("Hello user coming $users");
      print(users);
      if (!isClosed) emit(FetchAllUsersSuccess(users: users));
    } catch (e) {
      if (!isClosed) emit(FetchAllUsersFailure(message: e.toString()));
    }
  }
}
