import 'package:hola_academy/core/networking/Dio/Classes/dio_classes.dart';
import 'package:hola_academy/features/classes/Data/Model/classs_model.dart';
import 'package:hola_academy/features/classes/Data/Model/myclass_model.dart';

class ClassesRepo {
  final DioClasses _dioCategoriess;
  ClassesRepo(this._dioCategoriess);
  Future<List<ClasssModel>> getAllClasses() async {
    return await _dioCategoriess.getAllClasses();
  }

  Future<ClasssModel> getClassesyById(int id) async {
    return await _dioCategoriess.getClassesyById(id);
  }

  Future<List<ClasssModel>> getClassesyByLevel(int id) async {
    return await _dioCategoriess.getClassesByLevel(id);
  }

  Future<List<MyClassModel>> getmyClass() async {
    return await _dioCategoriess.getmyClasses();
  }
}
