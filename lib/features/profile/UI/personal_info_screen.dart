import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hola_academy/core/components/custom_colored_outline_button.dart';
import 'package:hola_academy/core/components/general_text_form_field.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/auth/login/Logic/login_cubit.dart';
import 'package:hola_academy/features/not_found/not_found_screen.dart';
import 'package:hola_academy/features/profile/Data/Model/update_user_model.dart';
import 'package:hola_academy/features/profile/Data/Model/user_model.dart';
import 'package:hola_academy/features/profile/Logic/personal_info/user_data_cubit.dart';
import 'package:hola_academy/features/profile/UI/widgets/custom_profile_app_bar.dart';
import 'package:hola_academy/features/profile/UI/widgets/custom_profile_backgroung.dart';
import 'package:intl/intl.dart';
import '../../../core/dependency_injection/dependency.dart';
import '../../../core/local_db/save_token.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController parentNameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController parentWhatsappNumberController =
      TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  String? birthDate;
  String? selectedGender;

  final List<String> genderOptions = ['Male', 'Female'];

  String? _userRole;
  UserModel? userModel;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 18.h,
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
              minWidth: MediaQuery.of(context).size.width,
            ),
            child: IntrinsicHeight(
              child: BlocConsumer<UserDataCubit, UserDataState>(
                listener: (context, state) {
                  if (state is UserDataSuccess) {
                    nameController.text = state.userModel.name ?? '';
                    parentNameController.text =
                        state.userModel.parentName ?? '';
                    phoneController.text = state.userModel.phoneNumber ?? '';
                    birthDate = DateFormat('dd/MM/yyyy').format(
                        DateTime.parse(state.userModel.dob ?? '').toLocal());
                    parentWhatsappNumberController.text =
                        state.userModel.parentWhatsappNumber.toString();
                    emailController.text = state.userModel.email ?? '';
                    selectedGender = state.userModel.gender;
                    userModel = state.userModel;
                  }
                  if (state is PickImageSuccess) {
                    context.read<UserDataCubit>().profileImage =
                        state.profileImage;
                  }
                },
                builder: (context, state) {
                  UserDataCubit userDataCubit = context.read<UserDataCubit>();
                  if (state is UserDataLoading ||
                      state is UpdateUserDataLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: ColorManager.textRedColor,
                    ));
                  } else if (state is UserDataFailure ||
                      state is UpdateUserDataFailure) {
                    return NotFoundScreen();
                  } else {
                    return Column(children: [
                      Stack(alignment: Alignment.topCenter, children: [
                        CustomProfileBackgroung(
                          isEdit: true,
                        ),
                        BlocProvider(
                          create: (context) =>  getIT<LoginCubit>(),
                          child: CustomProfileAppBar(
                            qrCode: true,
                            isLayout: _userRole == AppString.admin,
                          ),
                        ),
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
                                label: AppString.firstName,
                                labelStyle: TextStyle(
                                  fontSize: 18.sp,
                                  color: const Color.fromARGB(255, 52, 52, 52),
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
                                hint: parentNameController.text,
                                label: AppString.parentName,
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
                                controller: parentNameController,
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
                              // if (coach)
                              if (_userRole == AppString.preuser ||
                                  _userRole == AppString.user ||
                                  _userRole == AppString.trainee) ...[
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
                              GeneralTextFormField(
                                label: AppString.birthDay,
                                hint: birthDate ?? '',
                                labelStyle: TextStyle(
                                  fontSize: 18.sp,
                                  color: ColorManager.blackFontColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                isFill: false,
                                isBorder: true,
                                readOnly: true,
                                suffixIcon: GeneralTextFormField.createIcon(
                                  Icons.calendar_month,
                                  color: ColorManager.textRedColor,
                                ),
                                keyboardType: TextInputType.datetime,
                                onTap: () async {},
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a date';
                                  }
                                  return null;
                                },
                              ),
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
                                readOnly: true,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 0.w),
                                    child: SvgPicture.asset(
                                      ImageManager.gender,
                                      width: 24.w,
                                    ),
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
                                    var pic = context
                                        .read<UserDataCubit>()
                                        .profileImage;
                                    if (nameController.text !=
                                            userModel?.name ||
                                        parentNameController.text !=
                                            userModel?.parentName ||
                                        pic != null) {
                                      UpdateUserModel updateUserModel =
                                          UpdateUserModel(
                                        name: nameController.text,
                                        parentName: parentNameController.text,
                                        picture: pic,
                                      );
                                      userDataCubit
                                          .updateMyData(updateUserModel);
                                    }
                                  })
                            ],
                          ),
                        ),
                      )
                    ]);
                  }
                },
              ),
            ),
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

String formatDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat('dd-MM-yyyy').format(dateTime); // Change format as needed
}
