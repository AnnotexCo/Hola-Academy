import 'package:hola_academy/core/networking/Dio/Category/dio_categoriess.dart';
import 'package:hola_academy/features/classes/Data/Model/category_model.dart';

class CategoriesRepo {
  final DioCategoriess dioCategoriess;

  CategoriesRepo({required this.dioCategoriess});

  Future<List<CategoryModel>> getAllCategories() async {
    return await dioCategoriess.getAllCategories();
  }

  Future<CategoryModel> getCategoryById(int id) async {
    return await dioCategoriess.getCategoryById(id);
  }

}
