import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hola_academy/features/classes/Data/Model/levels_model.dart';
import 'package:hola_academy/features/classes/Data/Repo/levels_repo.dart';

part 'levels_state.dart';

class LevelsCubit extends Cubit<LevelsState> {
  final LevelsRepo levelsRepo;
  LevelsCubit(this.levelsRepo) : super(LevelsInitial());

  fetchLevelsbyID(int id) async {
    try {
      if (!isClosed) emit(LevelsLoading());

      final model = await levelsRepo.fetchLevelsbyID(id);
      if (!isClosed) emit(LevelsSuccess(model));
    } catch (e) {
      if (!isClosed) emit(LevelsError(message: e.toString()));
    }
  }
}
