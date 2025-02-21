import 'package:equatable/equatable.dart';

import '../../Data/Model/banner_model.dart';

abstract class BannerState extends Equatable {
  @override
  List<Object> get props => [];
}

class BannerInitial extends BannerState {}

class BannerLoading extends BannerState {}


class AllBannersSuccess extends BannerState {
  final List<BannerModel> banners;
  AllBannersSuccess(this.banners);

  @override
  List<Object> get props => [banners];
}

class SingleBannerSuccess extends BannerState {
  final BannerModel banner;
  SingleBannerSuccess(this.banner);

  @override
  List<Object> get props => [banner];
}
class BannerError extends BannerState {
  final String message;
  BannerError(this.message);

  @override
  List<Object> get props => [message];
}
