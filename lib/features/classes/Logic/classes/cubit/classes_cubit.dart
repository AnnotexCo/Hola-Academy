import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hola_academy/features/classes/Data/Model/classs_model.dart';
import 'package:hola_academy/features/classes/Data/Repo/classes_repo.dart';

part 'classes_state.dart';

class ClassesCubit extends Cubit<ClassesState> {
  final ClassesRepo classesRepo;
  List<ClasssModel> classes = [];
  ClassesCubit(this.classesRepo) : super(ClassesInitial()) {
    getAllClasses();
  }

  Future<void> getAllClasses() async {
    emit(ClassesLoading());
    try {
      classes = await classesRepo.getAllClasses();
      print("  Yaaaaaaaboy $classes");
      emit(ClassesLoaded(classes: classes));
    } catch (error) {
      emit(ClassesError(error: error.toString()));
    }
  }

  Future<void> getClassById(String id) async {
    emit(ClassesLoading());
    try {
      emit(ClassesLoaded(classes: classes));
    } catch (error) {
      emit(ClassesError(error: error.toString()));
    }
  }
}
