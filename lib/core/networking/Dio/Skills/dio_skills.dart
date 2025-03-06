import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hola_academy/core/constants/api_constants.dart';
import 'package:hola_academy/core/networking/ErrorHandler/api_error_handler.dart';

import '../../../../features/classes/Data/Model/evaluations_model.dart';
import '../../../../features/classes/Data/Model/skills_model.dart';

class DioSkills {
  final Dio _dio;

  DioSkills({required Dio dio}) : _dio = dio;

  Future<List<Skill>> getSkillsbyLessonID(int lessonID) async {
    try {
      final response = await _dio.get(
          "${ApiConstants.baseUrl}${ApiConstants.getSkillsbyLessonsID}$lessonID",
          data: {
            "lessonId": lessonID,
          },
         );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        List<Skill> skills =
            Skill.fromJsonList(data['class']['level']['Skill']);

        return skills;
      }
      throw Exception("Failed to load program");
    } catch (error) {
      throw ApiErrorHandler.handle(error).message.toString();
    }
  }

  Future<List<Evaluation>> getEvaluationsbyLevelID(int lessonID) async {
    try {
      final response = await _dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.getEvaluationsbyLessonID}$lessonID/evaluations",
        data: {
          "lessonId": lessonID,
        },
        
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];

        // Assuming that the evaluation data is inside the nested structure like 'class.level.Skill' or similar
        List<Evaluation> evaluations = Evaluation.fromJsonList(data);
        return evaluations;
      }
      throw Exception("Failed to load evaluations");
    } catch (error) {
      throw ApiErrorHandler.handle(error).message.toString();
    }
  }

  Future<void> evaluateSkill(
      int lessonID, int skillId, int score, bool passed, String notes) async {
    try {
      final response = await _dio.post(
          "${ApiConstants.baseUrl}${ApiConstants.evaluateSkillsbyLessonsID}",
          data: {
            "lessonId": lessonID,
            "skillId": skillId,
            "score": score,
            "passed": passed,
            "notes": notes
          },
        );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          print("Success");
        }
      }
    } catch (error) {
      throw error.toString();
    }
  }
}
