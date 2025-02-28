part of 'levels_cubit.dart';

sealed class LevelsState extends Equatable {
  const LevelsState();

  @override
  List<Object> get props => [];
}

final class LevelsInitial extends LevelsState {}

final class LevelsSuccess extends LevelsState {
  final List<LevelsModel> levels;
  const LevelsSuccess(this.levels);
}

final class LevelsLoading extends LevelsState {}

final class LevelsError extends LevelsState {
    final String message;

  const LevelsError({required this.message});

}
