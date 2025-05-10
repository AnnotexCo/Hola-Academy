import '../../../../core/networking/Dio/Program/dio_programs.dart';
import '../Model/programs_model.dart';

class ProgramsRepo {
  final DioPrograms dioPrograms;

  ProgramsRepo({required this.dioPrograms});

  Future<List<ProgramsModel>> getAllPrograms() async {
    return await dioPrograms.getAllPrograms();

  }

  Future<ProgramsModel> getProgramById(int id) async {
    return await dioPrograms.getProgramById(id);
  }
  
  
}
