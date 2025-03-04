part of 'skills_cubit.dart';

sealed class SkillsState extends Equatable {
  const SkillsState();

  @override
  List<Object> get props => [];
}

final class SkillsInitial extends SkillsState {}

final class SkillsLoading extends SkillsState {}

final class SkillsLoaded extends SkillsState {
  final List<Skill> skills;
  const SkillsLoaded({required this.skills});
}
final class SkillSucessfulyEvaluated extends SkillsState {
  const SkillSucessfulyEvaluated();
}

final class SkillsError extends SkillsState {
  final String error;
  const SkillsError({required this.error});
}
