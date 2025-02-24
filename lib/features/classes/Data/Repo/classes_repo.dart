import 'package:hola_academy/core/networking/Dio/Classes/dio_classes.dart';
import 'package:hola_academy/features/classes/Data/Model/classs_model.dart';

class ClassesRepo {
  final DioClasses _dioCategoriess;
  ClassesRepo(this._dioCategoriess);
  Future<List<ClasssModel>> getAllClasses() async {
    return await _dioCategoriess.getAllClasses();
  }

  Future<ClasssModel> getClassesyById(int id) async {
    return await _dioCategoriess.getClassesyById(id);
  }
}
