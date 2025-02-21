import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hola_academy/core/components/custom_colored_outline_button.dart';
import 'package:hola_academy/core/components/general_text_form_field.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/personal_info/Data/Model/update_user_model.dart';
import 'package:hola_academy/features/personal_info/Logic/user_data_cubit.dart';
import 'package:hola_academy/features/profile/UI/widgets/custom_profile_app_bar.dart';
import 'package:hola_academy/features/profile/UI/widgets/custom_profile_backgroung.dart';

import '../../../core/local_db/save_token.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController birthDayController = TextEditingController();

  final TextEditingController parentWhatsappNumberController =
      TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  String? selectedGender;

  final List<String> genderOptions = ['Male', 'Female'];

  String? _userRole;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
    context.read<UserDataCubit>().getMyData();
  }

  Future<void> _loadUserRole() async {
    String? role = await SaveTokenDB.getRole();
    setState(() {
      _userRole = role;
    });
  }

// ---------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 18.w,
          ),
          child: BlocConsumer<UserDataCubit, UserDataState>(
            listener: (context, state) {
              if (state is UpdateUserDataSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('User data updated successfully'),
                    backgroundColor: ColorManager.textRedColor,
                  ),
                );
              } else if (state is UserDataFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: ColorManager.errorRedColor,
                  ),
                );
              } else if (state is UpdateUserDataFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: ColorManager.errorRedColor,
                  ),
                );
              } else if (state is UserDataSuccess) {
                nameController.text = state.userModel.name;
                emailController.text = state.userModel.email;
                phoneController.text = state.userModel.phoneNumber;
                birthDayController.text = state.userModel.dob;
                parentWhatsappNumberController.text =
                    state.userModel.parentWhatsappNumber ?? '';
                selectedGender = state.userModel.gender;
              }
            },
            builder: (context, state) {
              if (state is UserDataLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.textRedColor,
                  ),
                );
              } else if (state is UserDataSuccess) {
                return Column(children: [
                  Stack(alignment: Alignment.topCenter, children: [
                    CustomProfileBackgroung(
                      name: nameController.text,
                    ),
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
                            hint: nameController.text,
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
                            hint: 'example@gmail.com',
                            label: AppString.emailAddress,
                            labelStyle: TextStyle(
                              fontSize: 18.sp,
                              color: ColorManager.blackFontColor,
                              fontWeight: FontWeight.w500,
                            ),
                            isFill: false,
                            isBorder: true,
                            readOnly: true,
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
                            readOnly: true,
                            suffixIcon: GestureDetector(
                              onTap: () => setState(() =>
                                  _isPasswordVisible = !_isPasswordVisible),
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
                              return null;
                            },
                          ),
                          // if (coach)
                          if (_userRole == AppString.preuser ||_userRole == AppString.user || _userRole == AppString.trainee) ...[
                            GeneralTextFormField(
                              label: AppString.birthDay,
                              hint: AppString.chooseYourBirthDate,
                              labelStyle: TextStyle(
                                fontSize: 18.sp,
                                color: ColorManager.blackFontColor,
                                fontWeight: FontWeight.w500,
                              ),
                              isFill: false,
                              isBorder: true,
                              //readOnly: true,
                              suffixIcon: GeneralTextFormField.createIcon(
                                Icons.calendar_month,
                                color: ColorManager.textRedColor,
                              ),
                              controller: birthDayController,
                              keyboardType: TextInputType.datetime,
                              onTap: () async {
                                // Open date picker
                                /*  DateTime? pickedDate = */ await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      insetPadding: EdgeInsets.only(
                                          left: 29.w, right: 29.w, top: 360.h),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      backgroundColor:
                                          ColorManager.backgroundPinkColor,
                                      child: Container(
                                        height: 241.h,
                                        decoration: BoxDecoration(
                                          color:
                                              ColorManager.backgroundPinkColor,
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          border: Border.all(
                                            color: ColorManager.textRedColor,
                                            width: 1,
                                          ),
                                        ),
                                        child: Theme(
                                          data: ThemeData.light().copyWith(
                                            colorScheme: ColorScheme.light(
                                                primary:
                                                    ColorManager.textRedColor),
                                            datePickerTheme:
                                                DatePickerThemeData(
                                                    todayBorder: BorderSide(
                                              color: ColorManager.textRedColor,
                                              style: BorderStyle.none,
                                              strokeAlign:
                                                  BorderSide.strokeAlignInside,
                                            )),
                                          ),
                                          child: CalendarDatePicker(
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime.now(),
                                            onDateChanged: (selectedDate) {
                                              setState(() {
                                                birthDayController.text =
                                                    "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                                              });
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a date';
                                }
                                return null;
                              },
                            ),
                            GeneralTextFormField(
                              hint: '+201258672352',
                              label: AppString.parentNumber,
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
                              controller: parentWhatsappNumberController,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                return null;
                              },
                            ),
                          ],
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
                            hint: selectedGender!,
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
                                padding: EdgeInsets.symmetric(horizontal: 0.w),
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
                        if (_formKey.currentState!.validate() &&
                            selectedGender != null) {
                          UpdateUserModel updateUserModel = UpdateUserModel(
                            name: nameController.text,
                            phoneNumber: phoneController.text,
                            gender: selectedGender,
                          );
                          userDataCubit.updateMyData(updateUserModel);
                        }
                        // Navigator.pop(context);
                      })
                ]);
              } else {
                return Center(
                  child: Text('Failed to load user data'),
                );
              }
            },
          ),
        ),
      )),
    );
  }

  Widget buildMenuItem({
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
