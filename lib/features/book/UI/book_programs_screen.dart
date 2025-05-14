import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';

import '../../../core/components/custom_app_bar.dart';
import '../../../core/components/custom_app_button.dart';
import '../../../core/constants/image_manager.dart';
import '../../../core/local_db/save_token.dart';
import '../../Admin/requests/Logic/requests_cubit.dart';
import '../../Admin/requests/Logic/requests_state.dart';
import '../../not_found/not_found_screen.dart';
import '../../profile/Data/Model/user_model.dart';
import '../../profile/Logic/personal_info/user_data_cubit.dart';
import '../Data/Model/booking_program_model.dart';
import 'widgets/additional_details_for_booking_section.dart';
import 'widgets/additional_notes_section.dart';
import 'widgets/payment_upload_section.dart';
import 'widgets/person_info_card.dart';

class BookProgramScreen extends StatefulWidget {
  final int programId;
  const BookProgramScreen({super.key, required this.programId});

  @override
  State<BookProgramScreen> createState() => _BookProgramScreenState();
}

class _BookProgramScreenState extends State<BookProgramScreen> {
  final TextEditingController noteController = TextEditingController();
  String? _userRole;
  UserModel? _userData;
  bool _isEditing =
      false; // State variable to toggle between card and edit section
  BookingProgramModel? _bookingData; // Store the saved booking data
  File? _paymentImage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadUserData(context);
  }

  Future<void> _loadUserData(context) async {
    final role = await SaveTokenDB.getRole();
    final userCubit = BlocProvider.of<UserDataCubit>(context, listen: false);
    await userCubit.getMyData();

    if (mounted) {
      final newUserData = userCubit.userModel;

      // Only update state if data has changed (avoids unnecessary rebuilds)
      if (_userData != newUserData) {
        setState(() {
          _userRole = role;
          _userData = newUserData;

          //  Initialize `_bookingData` only if it's null
          _bookingData ??= BookingProgramModel(
            programId: widget.programId,
            address: newUserData?.address,
            nationality: newUserData?.nationality,
            healthStatus: newUserData?.healthStatus,
            parentAddress: newUserData?.parentAddress,
            parentName: newUserData?.parentName,
            parentNationality: newUserData?.parentNationality,
            phoneNumber: newUserData?.phoneNumber,
          );
        });
      }
    }
  }

  bool get _hasCompleteProfile {
    return _userData?.address != null &&
        _userData?.nationality != null &&
        _userData?.healthStatus != null &&
        _userData?.parentAddress != null &&
        _userData?.parentName != null &&
        _userData?.parentNationality != null &&
        _userData?.phoneNumber != null;
  }

  void _handleBookProgram() {
    if (_bookingData == null) {
      _showSnackBar('Error loading booking data. Please try again.');
      return;
    }

    //  Ensure required fields are filled
    final missingFields = <String>[];
    if (_bookingData!.address == null) missingFields.add("Address");
    if (_bookingData!.nationality == null) missingFields.add("Nationality");
    if (_bookingData!.parentAddress == null)
      missingFields.add("Parent Address");
    if (_bookingData!.parentName == null) missingFields.add("Parent Name");
    if (_bookingData!.parentNationality == null)
      missingFields.add("Parent Nationality");
    if (_bookingData!.phoneNumber == null) missingFields.add("Phone Number");

    if (missingFields.isNotEmpty) {
      _showSnackBar("Please complete: ${missingFields.join(', ')}");
      return;
    }

    //  Validate phone number format
    if (!RegExp(r'^\+\d{10,15}$').hasMatch(_bookingData!.phoneNumber!.trim())) {
      _showSnackBar('Invalid phone number format. Use +20XXXXXXXXXX');
      return;
    }

    //  Validate note length
    if (noteController.text.isEmpty || noteController.text.length <= 6) {
      _showSnackBar('Note must be more than 6 characters.');
      return;
    }

    //  Update the existing object instead of creating a new one
    _bookingData = _bookingData!.copyWith(note: noteController.text);

    context
        .read<RequestsCubit>()
        .bookProgram(_bookingData!, imageFile: _paymentImage);
  }

// 🔹 Helper function to reduce duplicate code
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message), backgroundColor: ColorManager.errorRedColor),
    );
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing; // Toggle between edit mode and view mode
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<RequestsCubit, RequestsState>(
        listener: (context, state) {
          if (state is BookRequestSuccess) {
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppString.successfullyPurchased),
                backgroundColor: Colors.green,
              ),
            );
            // Navigate to the success screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new, size: 24.sp),
                    ),
                  ),
                  body: NotFoundScreen(
                    svgPath: ImageManager.successfullyPurchased,
                    title: AppString.successfullyPurchased,
                  ),
                ),
              ),
            );
          } else if (state is RequestsError) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: ColorManager.errorRedColor,
              ),
            );
          }
        },
        builder: (context, state) {
          return BlocConsumer<UserDataCubit, UserDataState>(
            listener: (context, state) {
              if (state is UserDataSuccess) {
                if (mounted) {
                  _userData = state.userModel;

                  //  Avoid unnecessary re-renders
                  _bookingData ??= BookingProgramModel(
                    programId: widget.programId,
                    address: _userData?.address,
                    nationality: _userData?.nationality,
                    healthStatus: _userData?.healthStatus,
                    parentAddress: _userData?.parentAddress,
                    parentName: _userData?.parentName,
                    parentNationality: _userData?.parentNationality,
                    phoneNumber: _userData?.phoneNumber,
                  );
                }
              }

              if (state is UserDataFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: ColorManager.errorRedColor,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is UserDataLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      title: AppString.bookProgram,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        children: [
                          if (_userRole != AppString.preuser) ...[
                            if (!_isEditing) // Show PersonalInfoCard when not editing
                              PersonalInfoCard(
                                userData: _userData,
                                onEditPressed:
                                    _toggleEditing, // Toggle to edit mode
                              ),
                            if (_isEditing) // Show AdditionalDetailsForBookingSection when editing
                              AdditionalDetailsForBookingSection(
                                programId: widget.programId,
                                userData: _userData,
                                onSavePressed: (bookingData) {
                                  setState(() {
                                    _bookingData = bookingData;
                                  });
                                }, // Toggle back to view mode
                              ),
                            SizedBox(height: 32.h),
                          ],
                          buildAdditionalNotesSection(
                              controller: noteController),
                          SizedBox(height: 32.h),
                          PaymentUploadSection(
                            onImageSelected: (image) => _paymentImage = image,
                          ),
                          SizedBox(height: 32.h),
                          buildBookButton(context),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildBookButton(BuildContext context) {
    return Center(
      child: CustomAppButton(
          text: AppString.book,
          onPressed: _hasCompleteProfile
              ? _handleBookProgram
              : () {
                  // Show a message if the profile is incomplete
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Please complete your profile to book the program.'),
                      backgroundColor: ColorManager.errorRedColor,
                    ),
                  );
                }),
    );
  }
}
