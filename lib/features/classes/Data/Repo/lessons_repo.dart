import 'package:hola_academy/core/networking/Dio/Lessons/dio_lessons.dart';
import 'package:hola_academy/features/classes/Data/Model/lessons_model.dart';

class LessonsRepo {
  final DioLessons dioLessons;

  LessonsRepo({required this.dioLessons});

  Future<List<LessonModel>> getmyLessons() async {
    return await dioLessons.getLessonsByTrainee();
  }

  Future<List<LessonModel>> getLessonsByID(int traineeID, int classID) async {
    return await dioLessons.getLessonsByID(traineeID, classID);
  }

  Future<LessonModel> getNextLessons() async {
    return await dioLessons.getMyNextLessons();
  }

  Future<List<LessonModel>> getLessonsByDate(String startDate, String endDate) {
    return dioLessons.getLessonsByDate(startDate, endDate);
  }
}
