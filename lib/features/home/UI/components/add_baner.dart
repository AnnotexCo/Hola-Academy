import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/api_constants.dart';
import '../../Logic/banner_logic/banner_cubit.dart';
import '../../Logic/banner_logic/banner_state.dart';
import '../Loading/banners_loading.dart';

class AddBaner extends StatelessWidget {
  const AddBaner({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannersCubit, BannerState>(builder: (context, state) {
      if (state is BannerLoading) {
        return buildbannerLoading();
      } else if (state is AllBannersSuccess) {
        if (state.banners.isEmpty) {
          return _buildPlaceholder(); // Handle empty banner
        }
        final banner = state.banners.first;
        final String imageUrl =
            '${ApiConstants.imagesURLApi}${banner.image.path}';
        return SizedBox(
          height: 107.h,
          width: 380.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => buildbannerLoading(),
              errorWidget: (context, url, error) =>_buildPlaceholder(),
            ),
          ),
        );
      } else if (state is SingleBannerSuccess) {
        if (state.banner.image.path.isEmpty) {
           return _buildPlaceholder(); // Handle empty banner
        }
        final String imageUrl =
            '${ApiConstants.imagesURLApi}${state.banner.image.path}';
        return SizedBox(
          height: 107.h,
          width: 380.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => buildbannerLoading(),
              errorWidget: (context, url, error) => _buildPlaceholder(),
            ),
          ),
        );
      } else if (state is BannerError) {
        return Center(child: Text("Error: ${state.message}"));
      }
      return buildbannerLoading();
    });
  }
    Widget _buildPlaceholder() {
    return Container(
      height: 107.h,
      width: 380.w,
      decoration: BoxDecoration(
        color: Colors.grey[300], 
        borderRadius: BorderRadius.circular(20.r),
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.image_not_supported,
        size: 50.sp,
        color: Colors.grey[600],
      ),
    );
  }
}
