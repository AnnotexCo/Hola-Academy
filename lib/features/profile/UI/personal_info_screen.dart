import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hola_academy/core/components/custom_colored_outline_button.dart';
import 'package:hola_academy/core/components/general_text_form_field.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/profile/UI/widgets/custom_profile_app_bar.dart';
import 'package:hola_academy/features/profile/UI/widgets/custom_profile_backgroung.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;

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
              child: Form(
                key: _formKey,
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
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        if (value.length < 2) {
                          return 'First name must be at least 2 characters';
                        }
                        if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                          return 'First name can only contain letters';
                        }
                        return null;
                      },
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
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                            .hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
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
                      suffixIcon: GestureDetector(
                        onTap: () => setState(
                            () => _isPasswordVisible = !_isPasswordVisible),
                        child: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: ColorManager.textRedColor,
                        ),
                      ),
                      isPassword: !_isPasswordVisible,
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                          return 'Password must include at least one uppercase letter';
                        } else if (!RegExp(r'[a-z]').hasMatch(value)) {
                          return 'Password must include at least one lowercase letter';
                        } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                          return 'Password must include at least one number';
                        } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                            .hasMatch(value)) {
                          return 'Password must include at least one special character';
                        }
                        return null;
                      },
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
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
                          return 'Enter a valid phone number (10-15 digits)';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
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
                  //if (_formKey.currentState!.validate() &&
                  //selectedGender != null) {
                  // Process data
                  //}
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
