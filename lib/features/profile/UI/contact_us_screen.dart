import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/core/dependency_injection/dependency.dart';
import 'package:hola_academy/features/profile/Logic/personal_info/user_data_cubit.dart';
import 'package:hola_academy/features/profile/UI/widgets/custom_profile_app_bar.dart';
import 'package:hola_academy/features/profile/UI/widgets/custom_profile_backgroung.dart';
import 'package:hola_academy/features/profile/UI/widgets/social_media_card.dart';

class ContactUsScreen extends StatefulWidget {
  ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 18.w,
          ),
          child: Column(children: [
            BlocProvider(
              create: (context) => getIT<UserDataCubit>()..getMyData(),
              child: Stack(alignment: Alignment.topCenter, children: [
                CustomProfileBackgroung(),
                CustomProfileAppBar(qrCode: true),
              ]),
            ),
            SizedBox(
              height: 80.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: SizedBox(
                height: 306.h,
                child: ListView.separated(
                  itemCount: socialMediaList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final socialMedia = socialMediaList[index];
                    return SocialMediaCard(
                      name: socialMedia.name,
                      iconPath: socialMedia.iconPath,
                    );
                  },
                ),
              ),
            ),
          ]),
        ),
      )),
    );
  }

  final List<SocialMedia> socialMediaList = [
    SocialMedia(AppString.instagram, ImageManager.instagram),
    SocialMedia(AppString.facebook, ImageManager.facebook),
    SocialMedia(AppString.tikTok, ImageManager.tiktok),
    SocialMedia(AppString.whatsApp, ImageManager.whatsapp),
  ];
}

class SocialMedia {
  final String name;
  final String iconPath;

  SocialMedia(this.name, this.iconPath);
}
