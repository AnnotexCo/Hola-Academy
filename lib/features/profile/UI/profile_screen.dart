import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/profile/UI/widgets/custom_profile_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 18.w,
        ),
        child: Column(children: [
          Stack(alignment: Alignment.topCenter, children: [
            _buildProfileBackground(),
            CustomProfileAppBar(qrCode: true),
          ]),
          Spacer(),
          Container(
            //height: 341.h,
            width: 385.w,
            decoration: BoxDecoration(
              color: ColorManager.whiteColor,
              borderRadius: BorderRadius.all(
                Radius.circular(12.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.shadowColor,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(1, 2),
                )
              ],
            ),
            child: ListView(
              shrinkWrap: true, // Adjusts to content size
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildMenuItem(
                  icon: ImageManager.personalInformation,
                  text: AppString.personalInformation,
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: ImageManager.analysis,
                  text: AppString.analytics,
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: ImageManager.transaction,
                  text: AppString.transaction,
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: ImageManager.booking,
                  text: AppString.booked,
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: ImageManager.terms,
                  text: AppString.terms,
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: ImageManager.sms,
                  text: AppString.contactUs,
                  onTap: () {},
                  last: true,
                ),
              ],
            ),
          ),
          Spacer(),
        ]),
      )),
    );
  }

  Widget _buildProfileBackground() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(ImageManager.profileFrame),
        Column(
          children: [
            Stack(
              children: [
                // Profile image inside a circular border
                Container(
                  height: 150.h,
                  width: 150.w,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          ColorManager.linearGradient1,
                          ColorManager.linearGradient2,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                  child: Center(
                    child: Container(
                      height: 140.h,
                      width: 140.w,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                          'https://s3-alpha-sig.figma.com/img/e915/f882/38ac6007aa5be950081f8f386a727a10?Expires=1737936000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=q7Gqf~xP2DuXMzmxmyIllwcM4Bi2JqGk~M78tq5nYVmVHgqta1RtLLVgxx~UkJgYfaiZpk090R7glwe6Y9DP3CO0ItgZW~RrpJqcmzMoalU9YR8hfUm~azHvjtc1xfCaaExOQnP6UV1aOPvx8QizON25RBlvYizobt3jTiqVmKcL0pwIcaSFAh1qQ6fe5GayPDxfW9Ds~8fiyqxVzK0l6zl~nKa9L-otRwWfs5NL~6R3kHhmmwuH2P9Vjji8yo192lzPi-TRxkIY9JRzX1zCMPK57N4cRGMvMO4tnW0gZxlDjAWuDzzpsYVtw5efQLCbQ-hQMM31vAXcr1g-RI8Tlg__'), // Replace with your image URL
                    ),
                  ),
                ),
                // Edit icon
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: ColorManager.backgroundPinkColor,
                    child: Icon(
                      Icons.edit,
                      color: ColorManager.textRedColor,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'Jennifer James',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required String icon,
    required String text,
    bool last = false,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      //height: 32.h,
      width: 349.w,
      child: Column(
        children: [
          ListTile(
            leading: SvgPicture.asset(
              icon,
            ),
            title: Text(
              text,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: ColorManager.lightGreyForFontColor,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: ColorManager.errorRedColor,
              size: 24.w,
            ),
            onTap: onTap,
          ),
          last
              ? Container()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 49.w),
                  child: Divider(
                    height: 1,
                    color: Colors.grey.shade300,
                  ),
                ),
        ],
      ),
    );
  }
}
