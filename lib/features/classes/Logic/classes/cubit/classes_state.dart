part of 'classes_cubit.dart';

sealed class ClassesState extends Equatable {
  const ClassesState();

  @override
  List<Object> get props => [];
}

final class ClassesInitial extends ClassesState {}

final class ClassesLoading extends ClassesState {}

final class ClassesLoaded extends ClassesState {
  final List<ClasssModel> classes;
  const ClassesLoaded({required this.classes});
}

final class ClassesError extends ClassesState {
  final String error;
  const ClassesError({required this.error});
}
