import 'package:bloc/bloc.dart';

import '../../Data/Repo/programs_repo.dart';
import 'programs_state.dart';

class ProgramsCubit extends Cubit<ProgramsState> {
  final ProgramsRepo programRepo;

  ProgramsCubit(this.programRepo) : super(ProgramsInitial());

  // Fetch all programs
  void fetchAllPrograms() async {
    try {
      emit(ProgramsLoading());
      final programs = await programRepo.getAllPrograms();
      emit(ProgramsSuccess(programs));
    } catch (e) {
      emit(ProgramsError(e.toString()));
    }
  }

  // Fetch a program by ID
  void fetchProgramById(int id) async {
    try {
      emit(ProgramsLoading());
      final program = await programRepo.getProgramById(id);
      emit(ProgramSuccess(program));
    } catch (e) {
      emit(ProgramsError(e.toString()));
    }
  }
}
