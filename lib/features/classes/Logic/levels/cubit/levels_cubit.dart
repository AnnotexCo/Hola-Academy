import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hola_academy/features/classes/Data/Model/levels_model.dart';
import 'package:hola_academy/features/classes/Data/Repo/levels_repo.dart';

part 'levels_state.dart';

class LevelsCubit extends Cubit<LevelsState> {
  final LevelsRepo levelsRepo; 
  LevelsCubit(this.levelsRepo) : super(LevelsInitial());

  fetchLevelsbyID (int id) async{

 try {
  emit(LevelsLoading());

 final model =  await  levelsRepo.fetchLevelsbyID(id);
emit(LevelsSuccess(model));
} on Exception catch (e) {
emit(LevelsError());
}
  }


}
