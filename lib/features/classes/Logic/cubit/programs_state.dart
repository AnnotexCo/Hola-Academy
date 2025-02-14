import 'package:equatable/equatable.dart';
import '../../Data/Model/programs_model.dart';

// Base state class
abstract class ProgramsState extends Equatable {
  @override
  List<Object> get props => [];
}

// Initial state
class ProgramsInitial extends ProgramsState {}

// Loading state
class ProgramsLoading extends ProgramsState {}

// Success state - for fetching all programs
class ProgramsSuccess extends ProgramsState {
  final List<ProgramsModel> programs;
  ProgramsSuccess(this.programs);

  @override
  List<Object> get props => [programs];
}

// Success state - for fetching a single program
class ProgramSuccess extends ProgramsState {
  final ProgramsModel program;
  ProgramSuccess(this.program);

  @override
  List<Object> get props => [program];
}

// Error state
class ProgramsError extends ProgramsState {
  final String message;
  ProgramsError(this.message);

  @override
  List<Object> get props => [message];
}
