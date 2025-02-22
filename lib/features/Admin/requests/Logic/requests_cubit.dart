import 'package:flutter_bloc/flutter_bloc.dart';

import '../Data/Repo/requests_repo.dart';
import 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  final RequestsRepo requestsRepo;

  RequestsCubit(this.requestsRepo) : super(RequestsInitial());

  // fetch all requests
  void fetchAllRequests() async {
    try {
      emit(RequestsLoading());
      final requestsList = await requestsRepo.fetchAllRequests();
      emit(AllRequestsSuccess(requestsList));
    } catch (error) {
      emit(RequestsError(error.toString()));
    }
  }

  // fetch request by id
  void fetchRequestById(int id) async {
    try {
      emit(RequestsLoading());
      final request = await requestsRepo.fetchRequestById(id);
      emit(SingleRequestSuccess(request));
    } catch (error) {
      emit(RequestsError(error.toString()));
    }
  }
}