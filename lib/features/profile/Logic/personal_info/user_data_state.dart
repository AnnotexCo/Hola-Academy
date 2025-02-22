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
