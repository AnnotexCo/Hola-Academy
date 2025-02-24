import 'dart:io';

import 'package:hola_academy/core/networking/Dio/Requests/dio_requests_api.dart';

import '../../../../book/Data/Model/booking_program_model.dart';
import '../Model/requests_model.dart';

class RequestsRepo {
  final DioRequestsApi dioRequestsApi;

  RequestsRepo({required this.dioRequestsApi});

  Future<List<RequestsModel>> fetchAllRequests() async {
    return await dioRequestsApi.fetchAllRequests();
  }

  Future<RequestsModel> fetchRequestById(int id) async {
    return await dioRequestsApi.fetchRequestById(id);
  }

  Future<void> bookProgram(BookingProgramModel bookingProgramModel, {File? imageFile}) async {
    await dioRequestsApi.bookProgram(
      bookingProgramModel.toJson(), 
      imageFile,
    );
  }
}
