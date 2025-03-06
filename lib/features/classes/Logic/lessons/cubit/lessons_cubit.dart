import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hola_academy/features/classes/Data/Model/lessons_model.dart';
import 'package:hola_academy/features/classes/Data/Repo/lessons_repo.dart';

part 'lessons_state.dart';

class LessonsCubit extends Cubit<LessonsState> {
  final LessonsRepo repo;

  LessonsCubit(this.repo) : super(LessonsInitial());

  Future<void> getLessonsbyDate(String startDate, String endDate) async {
    emit(LessonsLoading());
    try {
      print("startDate: $startDate, endDate: $endDate");
      final lessons = await repo.getLessonsByDate(startDate, endDate);
      emit(LessonsSuccess(lessons: lessons));
    } catch (e) {
      emit(LessonsError(message: e.toString()));
    }
  }

  List<LessonModel>? lessonModel;
  getLessons() async {
    emit(LessonsLoading());
    try {
      final lessons = await repo.getmyLessons();
      lessonModel = lessons;
      print('lessons: $lessons');
      emit(LessonsSuccess(lessons: lessons));
    } catch (e) {
      emit(LessonsError(message: e.toString()));
    }
  }

  getLessonsByID(int traineeID, int classID) async {
    try {
      emit(LessonsLoading());

      final lessons = await repo.getLessonsByID(traineeID, classID);
      emit(LessonsSuccess(lessons: lessons));
    } catch (e) {
      emit(LessonsError(message: e.toString()));
    }
  }

  LessonModel? nextLessons;
  getNextLessons() async {
    try {
      emit(LessonsLoading());
      final lessons = await repo.getNextLessons();
      nextLessons = lessons;

      emit(NextLessonsSuccess(lessons: lessons));
    } catch (e) {
      emit(LessonsError(message: e.toString()));
    }
  }
}
