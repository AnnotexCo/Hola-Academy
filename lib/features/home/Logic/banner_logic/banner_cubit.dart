import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hola_academy/features/home/Data/Repo/banner_repo.dart';

import 'banner_state.dart';

class BannersCubit extends Cubit<BannerState> {
  final BannerRepo bannerRepo;
  BannersCubit(this.bannerRepo) : super(BannerInitial());

  // fetch all banners
  void fetchAllBanners() async {
    try {
      emit(BannerLoading());
      final banners = await bannerRepo.getAllBanners();
      emit(AllBannersSuccess(banners));
    } catch (e) {
      emit(BannerError(e.toString()));
    }
  }

  // fetch single banner by id
  void fetchBannerById(int id) async {
    try {
      emit(BannerLoading());
      final banner = await bannerRepo.getBannerById(id);
      emit(SingleBannerSuccess(banner));
    } catch (e) {
      emit(BannerError(e.toString()));
    }
  }
}
