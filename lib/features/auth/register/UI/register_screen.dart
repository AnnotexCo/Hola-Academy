import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/auth/login/UI/login_screen.dart';
import 'package:hola_academy/features/auth/register/UI/widgets/custom_button.dart';
import 'package:hola_academy/features/auth/register/UI/widgets/custom_drop_down_selection.dart';
import 'package:hola_academy/features/auth/register/UI/widgets/custom_text_form_field.dart';
import 'package:hola_academy/features/auth/register/UI/widgets/terms_dialog.dart';
import 'package:hola_academy/features/profile/UI/profile_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController parentPhoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthDayController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final TextEditingController readController = TextEditingController();
  bool isTermsRead = false;
  String? selectedGender;
  final List<String> genderOptions = ['Male', 'Female'];
  String? selectedHearAboutUs;
  final List<String> hearAboutUsOptions = ['Social media', 'From friend'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 863.h,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60.r),
                  topRight: Radius.circular(60.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 21.h),
                    Text(
                      AppString.register,
                      style: TextStyle(
                          color: ColorManager.textRedColor,
                          fontSize: 43.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 29.w,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          spacing: 10.h,
                          children: [
                            CustomTextFormField(
                              label: AppString.fullName,
                              hint: AppString.firstName,
                              prefixIcon: Icons.person,
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
                            CustomTextFormField(
                              label: AppString.phoneNumber,
                              hint: AppString.yourPhone,
                              prefixIcon: Icons.phone,
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
                            CustomTextFormField(
                              label: AppString.parentNumber,
                              hint: AppString.whatsAppNumber,
                              prefixIcon: Icons.phone,
                              controller: parentPhoneController,
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
                            CustomTextFormField(
                              label: AppString.emailAddress,
                              hint: AppString.enterYourEmail,
                              prefixIcon: Icons.email,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email address';
                                }
                                // Regular Expression for email validation
                                if (!RegExp(
                                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                    .hasMatch(value)) {
                                  return 'Enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            CustomTextFormField(
                              label: AppString.birthDay,
                              hint: AppString.chooseYourBirthDate,
                              readOnly: true,
                              prefixIcon: Icons.calendar_month,
                              controller: birthDayController,
                              keyboardType: TextInputType.datetime,
                              onTap: () async {
                                // Open date picker
                                DateTime? pickedDate = await showDialog(
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
                                        height: 241.h, // 60% of screen height
                                        decoration: BoxDecoration(
                                          color:
                                              ColorManager.backgroundPinkColor,
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          border: Border.all(
                                            color: ColorManager
                                                .textRedColor, // Border color
                                            width: 1, // Border width
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
                                              Navigator.pop(
                                                  context); // Close the dialog after selection
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );

                                /*showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900), // Earliest date
                                  lastDate: DateTime.now(), // Latest date
                                  builder: (context, child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        primaryColor: ColorManager
                                            .backgroundPinkColor, // Header background color
                                        hintColor: ColorManager
                                            .textRedColor, // Selection color
                                        colorScheme: ColorScheme.light(
                                          primary: ColorManager
                                              .textRedColor, // Selection color
                                          onPrimary: Colors
                                              .white, // Text color on selection
                                          surface: Colors.red[
                                              50]!, // Calendar background color
                                        ),
                                        dialogBackgroundColor: ColorManager
                                            .backgroundPinkColor, // Background color
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            foregroundColor: ColorManager
                                                .textRedColor, // Button text color
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                        
                                if (pickedDate != null) {
                                  setState(() {
                                    birthDayController.text =
                                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                                  });
                                }*/
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a date';
                                }
                                return null;
                              },
                            ),
                            CustomDropDownSelection(
                              value: selectedGender,
                              hint: AppString.chooseYourGender,
                              label: AppString.gender,
                              options: genderOptions,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedGender =
                                      newValue; // Update the selected value
                                });
                              },
                            ),
                            CustomTextFormField(
                              label: AppString.password,
                              hint: AppString.enterYourPassword,
                              prefixIcon: Icons.lock_outline,
                              //suffixIcon: ImageManager.eye,
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
                                return null; // Validation passed
                              },
                            ),
                            CustomTextFormField(
                              label: AppString.confirmPassword,
                              hint: AppString.enterYourPassword,
                              prefixIcon: Icons.lock_outline,
                              suffixIcon: GestureDetector(
                                onTap: () => setState(() =>
                                    _isConfirmPasswordVisible =
                                        !_isConfirmPasswordVisible),
                                child: Icon(
                                  _isConfirmPasswordVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: ColorManager.textRedColor,
                                ),
                              ),
                              isPassword: !_isConfirmPasswordVisible,
                              controller: confirmPasswordController,
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
                                return null; // Validation passed
                              },
                            ),
                            CustomDropDownSelection(
                              value: selectedHearAboutUs,
                              hint: '',
                              label: AppString.howDidYouHearAboutUs,
                              options: hearAboutUsOptions,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedHearAboutUs =
                                      newValue; // Update the selected value
                                });
                              },
                            ),
                            Row(children: [
                              Checkbox(
                                value: isTermsRead,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isTermsRead = value ?? false;
                                  });
                                },
                                activeColor: ColorManager
                                    .textRedColor, // Checkbox fill color
                                checkColor: Colors.white, // Checkmark color
                                side: BorderSide(
                                  color:
                                      ColorManager.textRedColor, // Border color
                                  width: 2.0, // Border width
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return TermsDialog(
                                        onAgree: () {
                                          setState(() {
                                            isTermsRead = true;
                                          });
                                          Navigator.pop(context);
                                        },
                                        onDisagree: () {
                                          setState(() {
                                            isTermsRead = false;
                                          });
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Text(AppString.readTheTermsAndConditions,
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          ColorManager.textRedColor,
                                      color: ColorManager.textRedColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Montagu Slab',
                                    )),
                              ),
                            ]),
                            CustomButton(
                                text: AppString.signUp,
                                onTap: () {
                                  //if (_formKey.currentState!.validate() &&
                                  //  isTermsRead &&
                                  //selectedGender != null) {
                                  // Process data
                                  //}
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProfileScreen(),
                                      ));
                                }),
                            _buildSignUpPrompt(),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpPrompt() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppString.alreadyHaveAnAccount,
            style: TextStyle(
              color: ColorManager.textRedColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            AppString.login,
            style: TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: ColorManager.textRedColor,
              color: ColorManager.textRedColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageManager.onBoardingImage3),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
