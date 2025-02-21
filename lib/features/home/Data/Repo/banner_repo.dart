import '../../../../core/networking/Dio/Home/dio_banner_api.dart';
import '../Model/banner_model.dart';

class BannerRepo {
  final DioBannerApi dioBanners;

  BannerRepo({required this.dioBanners});

  Future<List<BannerModel>> getAllBanners() async {
    return await dioBanners.getAllBanners();
  }

  Future<BannerModel> getBannerById(int id) async {
    return await dioBanners.getBannerById(id);
  }
}