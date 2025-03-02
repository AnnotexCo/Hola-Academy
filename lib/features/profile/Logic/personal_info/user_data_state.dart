part of 'user_data_cubit.dart';

abstract class UserDataState {}

class UserDataInitial extends UserDataState {}

class UserDataLoading extends UserDataState {}

class UserDataSuccess extends UserDataState {
  final UserModel userModel;
  UserDataSuccess({required this.userModel});
}

class UserDataFailure extends UserDataState {
  final String message;
  UserDataFailure({required this.message});
}

class UpdateUserDataLoading extends UserDataState {}

class UpdateUserDataSuccess extends UserDataState {}

class UpdateUserDataFailure extends UserDataState {
  final String message;
  UpdateUserDataFailure({required this.message});
}

class PickImageSuccess extends UserDataState {
  final File profileImage;
  PickImageSuccess({required this.profileImage});
}

class FetchAllUsersSuccess extends UserDataState {
  final AllUsersModel users;
  FetchAllUsersSuccess({required this.users});
}
class FetchUsersByRoleSuccess extends UserDataState {
  final AllUsersModel users;
  FetchUsersByRoleSuccess({required this.users});
}

class FilterUsersSuccess extends UserDataState {
  final List<User> filteredUsers;
  FilterUsersSuccess({required this.filteredUsers});
}



class FetchAllUsersFailure extends UserDataState {
  final String message;
  FetchAllUsersFailure({required this.message});
}
class FetchUsersByRoleFailure extends UserDataState {
  final String message;
  FetchUsersByRoleFailure({required this.message});
}
