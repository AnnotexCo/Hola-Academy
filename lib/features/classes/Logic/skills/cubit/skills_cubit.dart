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
    if (!isClosed) emit(SkillsLoading());
    try {
      final skills = await skillsRepo.getSkillsbyLessonID(lessonID);
      if (!isClosed) emit(SkillsLoaded(skills: skills));
    } catch (e) {
      if (!isClosed) emit(SkillsError(error: e.toString()));
    }
  }

  Future<void> evaluateSkill(
    int lessonID,
    int skillId,
    int score,
    bool passed,
    String notes,
  ) async {
    if (!isClosed) emit(SkillsLoading());
    try {
      skillsRepo.evaluateSkill(lessonID, skillId, score, passed, notes);
      if (!isClosed) emit(SkillSucessfulyEvaluated());
    } catch (e) {
      if (!isClosed) emit(SkillsError(error: e.toString()));
    }
  }

  Future<void> getEvaluationsbyLevelID(int lessonID) async {
    if (!isClosed) emit(SkillsLoading());
    try {
      final evaluations = await skillsRepo.getEvaluationsbyLevelID(lessonID);
      if (!isClosed) emit(EvaluationsLoaded(evaluations: evaluations));
    } catch (e) {
      if (!isClosed) emit(SkillsError(error: e.toString()));
    }
  }
}
