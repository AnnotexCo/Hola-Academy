import 'package:hola_academy/features/classes/Data/Model/category_model.dart';

class LevelsModel {
final int id;
final String name;
  final ImageModel? image;


  LevelsModel({required this.image, required this.id, required this.name});


factory LevelsModel.fromMap(Map<String, dynamic> map) {
    return LevelsModel(
      image :map['Image'] != null ? ImageModel.fromJson(map['Image']) : null,
      name: map['name'] as String,
      id: map['id'] as int,
     
    );
  }
}

