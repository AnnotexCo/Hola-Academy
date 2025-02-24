import 'package:bloc/bloc.dart';
import '../../Data/Repo/programs_repo.dart';
import 'programs_state.dart';

class ProgramsCubit extends Cubit<ProgramsState> {
  final ProgramsRepo programRepo;
  

  ProgramsCubit(this.programRepo) : super(ProgramsInitial());

  // Fetch all programs
  void fetchAllPrograms() async {
    try {
    if (!isClosed) emit(ProgramsLoading());
      final programs = await programRepo.getAllPrograms();
      if (!isClosed) emit(ProgramsSuccess(programs));
    } catch (e) {
      if (!isClosed) emit(ProgramsError(e.toString()));
    }
  }

  // Fetch a program by ID
  void fetchProgramById(int id) async {
    try {
      if (!isClosed) emit(ProgramsLoading());
      final program = await programRepo.getProgramById(id);
      if (!isClosed) emit(SingleProgramSuccess(program));
    } catch (e) {
      if (!isClosed) emit(ProgramsError(e.toString()));
    }
  }
}
