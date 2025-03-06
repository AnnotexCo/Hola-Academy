import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hola_academy/features/classes/Data/Model/classs_model.dart';
import 'package:hola_academy/features/classes/Data/Model/myclass_model.dart';
import 'package:hola_academy/features/classes/Data/Repo/classes_repo.dart';

part 'classes_state.dart';

class ClassesCubit extends Cubit<ClassesState> {
  final ClassesRepo classesRepo;
  List<ClasssModel> classes = [];
  List<MyClassModel> myClasses = [];
  ClassesCubit(this.classesRepo) : super(ClassesInitial()) {
    getAllClasses();
  }

  Future<void> getAllClasses() async {
    if (!isClosed)  emit(ClassesLoading());
    try {
      classes = await classesRepo.getAllClasses();
      if (!isClosed) emit(ClassesLoaded(classes: classes));
    } catch (error) {
      if (!isClosed) emit(ClassesError(error: error.toString()));
    }
  }

  Future<void> getAllClassesbyLevelId(int id) async {
    if (!isClosed)  emit(ClassesLoading());
    try {
      classes = await classesRepo.getClassesyByLevel(id);
      if (!isClosed) emit(ClassesLoaded(classes: classes));
    } catch (error) {
      if (!isClosed) emit(ClassesError(error: error.toString()));
    }
  }

  Future<void> getClassById(String id) async {
    if (!isClosed) emit(ClassesLoading());
    try {
      if (!isClosed) emit(ClassesLoaded(classes: classes));
    } catch (error) {
      if (!isClosed) emit(ClassesError(error: error.toString()));
    }
  }

  Future<void> getmyClass() async {
    if (!isClosed)  emit(ClassesLoading());
    try {
      myClasses = await classesRepo.getmyClass();
      if (!isClosed) emit(MyClassesLoaded(classes: myClasses));
    } catch (error) {
      if (!isClosed) emit(ClassesError(error: error.toString()));
    }
  }
}
