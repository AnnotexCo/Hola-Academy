import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hola_academy/core/components/custom_colored_outline_button.dart';
import 'package:hola_academy/core/components/custom_text_field.dart';
import 'package:hola_academy/core/components/general_text_form_field.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/auth/register/UI/widgets/custom_drop_down_selection.dart';
import 'package:hola_academy/features/profile/UI/widgets/custom_profile_app_bar.dart';
import 'package:hola_academy/features/profile/UI/widgets/custom_profile_backgroung.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final bool _isPasswordVisible = false;

  String? selectedGender;

  final List<String> genderOptions = ['Male', 'Female'];

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
            Stack(alignment: Alignment.topCenter, children: [
              CustomProfileBackgroung(),
              CustomProfileAppBar(qrCode: true),
            ]),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w),
              child: Column(
                spacing: 8.h,
                children: [
                  GeneralTextFormField(
                    hint: 'Jennifer James',
                    label: AppString.fullName,
                    labelStyle: TextStyle(
                      fontSize: 18.sp,
                      color: ColorManager.blackFontColor,
                      fontWeight: FontWeight.w500,
                    ),
                    isFill: false,
                    isBorder: true,
                    suffixIcon: Icon(
                      Icons.person,
                      color: ColorManager.textRedColor,
                    ),
                  ),
                  GeneralTextFormField(
                    hint: 'Jennifer.James@gmail.com',
                    label: AppString.emailAddress,
                    labelStyle: TextStyle(
                      fontSize: 18.sp,
                      color: ColorManager.blackFontColor,
                      fontWeight: FontWeight.w500,
                    ),
                    isFill: false,
                    isBorder: true,
                    suffixIcon: Icon(
                      Icons.email,
                      color: ColorManager.textRedColor,
                    ),
                  ),
                  GeneralTextFormField(
                    hint: '*****************',
                    label: AppString.password,
                    labelStyle: TextStyle(
                      fontSize: 18.sp,
                      color: ColorManager.blackFontColor,
                      fontWeight: FontWeight.w500,
                    ),
                    isFill: false,
                    isBorder: true,
                    suffixIcon: Icon(
                      Icons.lock,
                      color: ColorManager.textRedColor,
                    ),
                  ),
                  /*CustomDropDownSelection(
                    value: selectedGender,
                    hint: AppString.chooseYourGender,
                    label: AppString.gender,
                    options: genderOptions,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue; // Update the selected value
                      });
                    },
                  ),*/
                  GeneralTextFormField(
                    hint: 'Female',
                    label: AppString.gender,
                    labelStyle: TextStyle(
                      fontSize: 18.sp,
                      color: ColorManager.blackFontColor,
                      fontWeight: FontWeight.w500,
                    ),
                    isFill: false,
                    isBorder: true,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: SvgPicture.asset(
                          ImageManager.gender,
                          width: 24.w,
                        ),
                      ),
                    ),
                  ),
                  GeneralTextFormField(
                    hint: '01258672352',
                    label: AppString.phoneNumber,
                    labelStyle: TextStyle(
                      fontSize: 18.sp,
                      color: ColorManager.blackFontColor,
                      fontWeight: FontWeight.w500,
                    ),
                    isFill: false,
                    isBorder: true,
                    suffixIcon: Icon(
                      Icons.person,
                      color: ColorManager.textRedColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomColoredOutlineButton(
                title: AppString.editYourinformation,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: ColorManager.textRedColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
                radius: 30.r,
                height: 43.h,
                width: 216.w,
                onTap: () {
                  Navigator.pop(context);
                })
          ]),
        ),
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
