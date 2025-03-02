import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hola_academy/features/classes/Data/Model/lessons_model.dart';
import 'package:hola_academy/features/classes/Data/Repo/lessons_repo.dart';

part 'lessons_state.dart';

class LessonsCubit extends Cubit<LessonsState> {
  final LessonsRepo repo;

  LessonsCubit(this.repo) : super(LessonsInitial());

  getLessons() async {
    emit(LessonsLoading());
    try {
      final lessons = await repo.getmyLessons();
      emit(LessonsSuccess(lessons: lessons));
    } catch (e) {
      emit(LessonsError(message: e.toString()));
    }
  }
}
