import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hola_academy/features/classes/Data/Model/lessons_model.dart';
import 'package:hola_academy/features/classes/Data/Repo/lessons_repo.dart';

part 'lessons_state.dart';

class LessonsCubit extends Cubit<LessonsState> {
  final LessonsRepo repo;

  LessonsCubit(this.repo) : super(LessonsInitial());

  Future<void> getLessonsbyDate(String startDate, String endDate) async {
    if (!isClosed) emit(LessonsLoading());
    try {
      final lessons = await repo.getLessonsByDate(startDate, endDate);
      if (!isClosed) emit(LessonsSuccess(lessons: lessons));
    } catch (e) {
      if (!isClosed) emit(LessonsError(message: e.toString()));
    }
  }

  List<LessonModel>? lessonModel;
  getLessons() async {
    if (!isClosed) emit(LessonsLoading());
    try {
      final lessons = await repo.getmyLessons();
      lessonModel = lessons;

      if (!isClosed) emit(LessonsSuccess(lessons: lessons));
    } catch (e) {
      if (!isClosed) emit(LessonsError(message: e.toString()));
    }
  }

  getLessonsByID(int traineeID, int classID) async {
    try {
      if (!isClosed) emit(LessonsLoading());

      final lessons = await repo.getLessonsByID(traineeID, classID);
      if (!isClosed) emit(LessonsSuccess(lessons: lessons));
    } catch (e) {
      if (!isClosed) emit(LessonsError(message: e.toString()));
    }
  }

  LessonModel? nextLessons;
  getNextLessons() async {
    try {
      if (!isClosed) emit(LessonsLoading());
      final lessons = await repo.getNextLessons();
      nextLessons = lessons;

      if (!isClosed) emit(NextLessonsSuccess(lessons: lessons));
    } catch (e) {
      if (!isClosed) emit(LessonsError(message: e.toString()));
    }
  }
}
