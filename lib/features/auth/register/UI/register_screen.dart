import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/auth/register/UI/widgets/custom_button.dart';
import 'package:hola_academy/features/auth/register/UI/widgets/custom_text_form_field.dart';
import 'package:hola_academy/features/auth/register/UI/widgets/gender_dialog.dart';
import 'package:hola_academy/features/auth/register/UI/widgets/terms_dialog.dart';

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
  final TextEditingController readController = TextEditingController();
  bool isTermsRead = false;
  String? selectedGender;
  final List<String> genderOptions = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageManager.onBoardingImage3),
                fit: BoxFit.cover,
              ),
            ),
          ),
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
                    Text(
                      AppString.register,
                      style: TextStyle(
                          color: ColorManager.textRedColor,
                          fontSize: 48.sp,
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
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  AppString.gender,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: ColorManager.textRedColor,
                                  ),
                                )),
                            Center(
                              child: Container(
                                height: 60.h,
                                padding: EdgeInsets.symmetric(horizontal: 19.w),
                                decoration: BoxDecoration(
                                  color: ColorManager
                                      .backgroundPinkColor, // Light background color
                                  borderRadius: BorderRadius.circular(
                                      12.r), // Rounded corners
                                ),
                                child: DropdownButton<String>(
                                  value:
                                      selectedGender, // Current selected value
                                  isExpanded:
                                      true, // Dropdown matches the container width
                                  underline:
                                      const SizedBox(), // Removes default underline
                                  icon: SvgPicture.asset(
                                    ImageManager.roundDoubleAltArrowDown,
                                    width: 24.w,
                                    height: 24.h,
                                  ),
                                  dropdownColor: ColorManager
                                      .backgroundPinkColor, // Dropdown menu background
                                  style: TextStyle(
                                    color:
                                        ColorManager.textRedColor, // Text color
                                    fontSize: 18, // Font size
                                    fontWeight: FontWeight.w400, // Font weight
                                  ),
                                  hint: Padding(
                                    padding: EdgeInsets.only(left: 19.w),
                                    child: Text(
                                      'Choose your gender', // Placeholder text
                                      style: TextStyle(
                                        color: ColorManager.textRedColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  items: genderOptions.map((String gender) {
                                    return DropdownMenuItem<String>(
                                      value: gender,
                                      child: Text(
                                        gender,
                                        style: TextStyle(
                                          // Default text color
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedGender =
                                          newValue; // Update the selected value
                                    });
                                  },
                                ),
                              ),
                            ),
                            CustomTextFormField(
                              label: AppString.password,
                              hint: AppString.enterYourPassword,
                              prefixIcon: Icons.lock_outline,
                              suffixIcon: ImageManager.eye,
                              isPassword: true,
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
                              suffixIcon: ImageManager.eye,
                              isPassword: true,
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
                            CustomTextFormField(
                              label: AppString.howDidYouHearAboutUs,
                              hint: '',
                              suffixIcon: ImageManager.roundDoubleAltArrowDown,
                              readOnly: true,
                              controller: readController,
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
                                      return TermsDialog();
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
                                  if (_formKey.currentState!.validate() &&
                                      isTermsRead &&
                                      selectedGender != null) {
                                    // Process data
                                  }
                                }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppString.alreadyHaveAnAccount,
                                  style: TextStyle(
                                    color: ColorManager.textRedColor,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  AppString.login,
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: ColorManager.textRedColor,
                                    color: ColorManager.textRedColor,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
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
}
