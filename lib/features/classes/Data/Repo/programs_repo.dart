import '../../../../core/networking/Dio/Program/dio_programs.dart';
import '../Model/programs_model.dart';

class ProgramsRepo {
  final DioPrograms dioProgram;

  ProgramsRepo({required this.dioProgram});

  Future<List<ProgramsModel>> getAllPrograms() async {
    return await dioProgram.getAllPrograms();
  }

  Future<ProgramsModel> getProgramById(int id) async {
    return await dioProgram.getProgramById(id);
  }
}
