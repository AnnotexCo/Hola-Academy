import 'package:hola_academy/core/networking/Dio/Skills/dio_skills.dart';
import 'package:hola_academy/features/classes/Data/Model/skills_model.dart';

class SkillsRepo {
  final DioSkills skills;

  SkillsRepo({required this.skills});

  Future<List<Skill>> getSkillsbyLessonID(int lessonID) async {
    return await skills.getSkillsbyLessonID(lessonID);
  }

  void evaluateSkill(
      int lessonID, int skillId, int score, bool passed, String notes) async {
    await skills.evaluateSkill(lessonID, skillId, score, passed, notes);
  }
}
