part of 'lessons_cubit.dart';

sealed class LessonsState extends Equatable {
  const LessonsState();

  @override
  List<Object> get props => [];
}

final class LessonsInitial extends LessonsState {}

final class LessonsSuccess extends LessonsState {
  final List<LessonModel> lessons;
  const LessonsSuccess({required this.lessons});
}

final class NextLessonsSuccess extends LessonsState {
  final LessonModel lessons;
  const NextLessonsSuccess({required this.lessons});
}

final class LessonsLoading extends LessonsState {}

final class LessonsError extends LessonsState {
  final String message;
  const LessonsError({required this.message});
}
