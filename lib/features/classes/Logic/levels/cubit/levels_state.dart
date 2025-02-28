part of 'levels_cubit.dart';

sealed class LevelsState extends Equatable {
  const LevelsState();

  @override
  List<Object> get props => [];
}

final class LevelsInitial extends LevelsState {}

final class LevelsSuccess extends LevelsState{

    final List<LevelsModel> model;
 const LevelsSuccess(this.model);

}
final class LevelsLoading extends LevelsState{}
final class LevelsError extends LevelsState{}