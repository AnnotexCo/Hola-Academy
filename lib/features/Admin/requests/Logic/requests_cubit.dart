import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../book/Data/Model/booking_program_model.dart';
import '../Data/Repo/requests_repo.dart';
import 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  final RequestsRepo requestsRepo;

  RequestsCubit(this.requestsRepo) : super(RequestsInitial());

  // fetch all requests
  void fetchAllRequests() async {
    try {
      if (!isClosed) emit(RequestsLoading());
      final requestsList = await requestsRepo.fetchAllRequests();
      print('Requestsss: $requestsList');
      if (!isClosed) emit(AllRequestsSuccess(requestsList));
    } catch (error) {
      if (!isClosed) emit(RequestsError(error.toString()));
    }
  }

  // fetch request by id
  void fetchRequestById(int id) async {
    try {
      if (!isClosed) emit(RequestsLoading());
      final request = await requestsRepo.fetchRequestById(id);
      if (!isClosed) emit(SingleRequestSuccess(request));
    } catch (error) {
      if (!isClosed) emit(RequestsError(error.toString()));
    }
  }

   // Book a program
 Future<void> bookProgram(BookingProgramModel bookingProgramModel, {File? imageFile}) async {
    try {
      if (!isClosed) emit(RequestsLoading());

      print("📤 Sending Booking Data: ${bookingProgramModel.toJson()}"); // Debugging log
      if (imageFile != null) print("📸 Image File: ${imageFile.path}"); // Debugging log

      await requestsRepo.bookProgram(bookingProgramModel, imageFile: imageFile); // ✅ Fixed call

      if (!isClosed) emit(BookRequestSuccess());
    } catch (error) {
      print("❌ Booking Error: $error");

      if (error is DioException) {
        final response = error.response?.data;

        if (response is List) {
          String errorMessage = response.join(", ");
          if (!isClosed) emit(RequestsError(errorMessage));
        } else if (response is Map && response.containsKey('message')) {
          if (!isClosed) emit(RequestsError(response['message']));
        } else {
          if (!isClosed) emit(RequestsError(error.message ?? "Unknown error occurred"));
        }
      } else {
        if (!isClosed) emit(RequestsError(error.toString()));
      }
    }
  }
}