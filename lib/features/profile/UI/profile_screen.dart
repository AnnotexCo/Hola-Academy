import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/profile/UI/contact_us_screen.dart';
import 'package:hola_academy/features/profile/UI/personal_info_screen.dart';
import 'package:hola_academy/features/profile/UI/terms_screen.dart';
import 'package:hola_academy/features/profile/UI/transactions_screen.dart';
import 'package:hola_academy/features/profile/UI/widgets/custom_profile_app_bar.dart';
import 'package:hola_academy/features/profile/UI/widgets/custom_profile_backgroung.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
            CustomProfileBackgroung(),
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
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return PersonalInfoScreen();
                      },
                    ));
                  },
                ),
                _buildMenuItem(
                  icon: ImageManager.analysis,
                  text: AppString.analytics,
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: ImageManager.transaction,
                  text: AppString.transaction,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return TransactionsScreen();
                      },
                    ));
                  },
                ),
                _buildMenuItem(
                  icon: ImageManager.booking,
                  text: AppString.booked,
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: ImageManager.terms,
                  text: AppString.terms,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return TermsScreen();
                      },
                    ));
                  },
                ),
                _buildMenuItem(
                  icon: ImageManager.sms,
                  text: AppString.contactUs,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ContactUsScreen();
                      },
                    ));
                  },
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
