import 'package:bloc/bloc.dart';
import 'package:hola_academy/features/classes/Data/Model/programs_model.dart';
import '../../Data/Repo/programs_repo.dart';
import 'programs_state.dart';

class ProgramsCubit extends Cubit<ProgramsState> {
  final ProgramsRepo programRepo;
  List<ProgramsModel> _allPrograms = []; // Store all programs

  ProgramsCubit(this.programRepo) : super(ProgramsInitial()) {
    fetchAllPrograms();
        print("Get All Prgorams");

  }

  // Fetch all programs
  void fetchAllPrograms() async {
    try {
      emit(ProgramsLoading());
      _allPrograms = await programRepo.getAllPrograms();
      emit(ProgramsSuccess(_allPrograms));
    } catch (e) {
      emit(ProgramsError(e.toString()));
    }
  }

  // Filter programs by category
  void filterPrograms({int? categoryId}) {
    if (_allPrograms.isNotEmpty) {
      final filtered = categoryId == null
          ? _allPrograms
          : _allPrograms.where((p) => p.category.id == categoryId).toList();
      emit(ProgramsSuccess(filtered));
    }
  }

  // Fetch a program by ID without resetting program list
  void fetchProgramById(int id) async {
    try {
      final program = await programRepo.getProgramById(id);
      emit(SingleProgramSuccess(program));
    } catch (e) {
      emit(ProgramsError(e.toString()));
    }
  }
}
