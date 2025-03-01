import 'package:hola_academy/core/networking/Dio/Lessons/dio_lessons.dart';
import 'package:hola_academy/features/classes/Data/Model/lessons_model.dart';

class LessonsRepo {
  final DioLessons dioLessons;

  LessonsRepo({required this.dioLessons});

  Future<List<LessonModel>> getmyLessons() async {
    return await dioLessons.getLessonsbytrainee();
  }
}
