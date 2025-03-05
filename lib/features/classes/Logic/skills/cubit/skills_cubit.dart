import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hola_academy/features/classes/Data/Model/evaluations_model.dart';
import 'package:hola_academy/features/classes/Data/Model/skills_model.dart';
import 'package:hola_academy/features/classes/Data/Repo/skills_repo.dart';

part 'skills_state.dart';

class SkillsCubit extends Cubit<SkillsState> {
  final SkillsRepo skillsRepo;
  SkillsCubit(this.skillsRepo) : super(SkillsInitial());

  Future<void> getSkillsbyLessonID(int lessonID) async {
    emit(SkillsLoading());
    try {
      final skills = await skillsRepo.getSkillsbyLessonID(lessonID);
      emit(SkillsLoaded(skills: skills));
    } catch (e) {
      emit(SkillsError(error: e.toString()));
    }
  }

  Future<void> evaluateSkill(
    int lessonID,
    int skillId,
    int score,
    bool passed,
    String notes,
  ) async {
    emit(SkillsLoading());
    try {
      skillsRepo.evaluateSkill(lessonID, skillId, score, passed, notes);
      emit(SkillSucessfulyEvaluated());
    } catch (e) {
      emit(SkillsError(error: e.toString()));
    }
  }

  Future<void> getEvaluationsbyLevelID(int lessonID) async {
    emit(SkillsLoading());
    try {
      final evaluations = await skillsRepo.getEvaluationsbyLevelID(lessonID);
      emit(EvaluationsLoaded(evaluations: evaluations));
    } catch (e) {
      emit(SkillsError(error: e.toString()));
    }
  }
}
