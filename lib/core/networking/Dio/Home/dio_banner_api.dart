import 'package:dio/dio.dart';
import 'package:hola_academy/features/home/Data/Model/banner_model.dart';

import '../../../constants/api_constants.dart';
import '../../ErrorHandler/api_error_handler.dart';

class DioBannerApi {
  final Dio _dio;

  DioBannerApi({required Dio dio}) : _dio = dio;

// fetch all banners
  Future<List<BannerModel>> getAllBanners() async {
    try {
      final response =
          await _dio.get("${ApiConstants.baseUrl}${ApiConstants.bannersApi}");

      if (response.statusCode == 200) {
        final bannerList = response.data['data'];

        if (bannerList is List) {
          return bannerList
              .map((json) => BannerModel.fromJson(json as Map<String, dynamic>))
              .toList();
        }
      }
      throw Exception("Failed to load banners");
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }

//  fetch a single banner by ID
  Future<BannerModel> getBannerById(int id) async {
    try {
      final response = await _dio
          .get("${ApiConstants.baseUrl}${ApiConstants.bannersApi}$id");

      if (response.statusCode == 200) {
        return BannerModel.fromJson(response.data['data']);
      }
      throw Exception("Failed to load banner");
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }
}
