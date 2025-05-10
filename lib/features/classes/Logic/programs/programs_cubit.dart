import 'package:bloc/bloc.dart';
import 'package:hola_academy/features/classes/Data/Model/programs_model.dart';
import '../../Data/Repo/programs_repo.dart';
import 'programs_state.dart';

class ProgramsCubit extends Cubit<ProgramsState> {
  final ProgramsRepo programRepo;
  List<ProgramsModel> _allPrograms = []; // Store all programs

  ProgramsCubit(this.programRepo) : super(ProgramsInitial()) {
    fetchAllPrograms();
  }

  // Fetch all programs
  void fetchAllPrograms() async {
    try {
      if (!isClosed) emit(ProgramsLoading());
      _allPrograms = await programRepo.getAllPrograms();
      if (!isClosed) emit(ProgramsSuccess(_allPrograms));
    } catch (e) {
      if (!isClosed) emit(ProgramsError(e.toString()));
    }
  }

  // Filter programs by category
  void filterPrograms({int? categoryId}) {
    if (_allPrograms.isNotEmpty) {
      final filtered = categoryId == null
          ? _allPrograms
          : _allPrograms.where((p) => p.category?.id == categoryId).toList();
      if (!isClosed) emit(ProgramsSuccess(filtered));
    }
  }

  // Fetch a program by ID without resetting program list
  void fetchProgramById(int id) async {
    // Avoid emitting ProgramsLoading if it's already in a loading state
    if (state is! SingleProgramLoading) {
      emit(SingleProgramLoading()); // Only emit if it's not already loading
    }
    try {
      final program = await programRepo.getProgramById(id);
      // Ensure we're emitting a single program success with the correct state
      if (!isClosed) {
        emit(SingleProgramSuccess(program));
      }
    } catch (e) {
      // Handle errors properly
      if (!isClosed) emit(SingleProgramError(e.toString()));
    }
  }
}
