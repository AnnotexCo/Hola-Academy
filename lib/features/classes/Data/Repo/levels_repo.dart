import 'package:hola_academy/core/networking/Dio/Levels/dio_levels.dart';
import 'package:hola_academy/features/classes/Data/Model/levels_model.dart';

class LevelsRepo {
  final DioLevels dioLevels;

  LevelsRepo({required this.dioLevels});

  Future<List<LevelsModel>> fetchLevelsbyID(int id) async {
    return await dioLevels.getLevelsbyId(id);
  }

  Future<List<LevelsModel>> fetchAllLevels() async {
    return await dioLevels.getAllLevels();
  }
}
