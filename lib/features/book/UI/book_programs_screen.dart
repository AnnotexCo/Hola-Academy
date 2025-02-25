
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:hola_academy/core/constants/app_string.dart';

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
  void initState() {
    super.initState();
    // Use addPostFrameCallback to ensure the context is valid
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData(context);
    });
  }

  Future<void> _loadUserData(BuildContext context) async {
    final role = await SaveTokenDB.getRole();
    await context.read<UserDataCubit>().getMyData();
    setState(() {
      _userRole = role;
      _userData = context.read<UserDataCubit>().userModel;
    });
  }
  // bool get _hasCompleteProfile {
  //   return _userData?.address != null &&
  //       _userData?.nationality != null &&
  //       _userData?.healthStatus != null &&
  //       _userData?.parentAddress != null &&
  //       _userData?.parentName != null &&
  //       _userData?.parentNationality != null &&
  //       _userData?.phoneNumber != null;
  // }

  void _handleBookProgram() {
    if (_bookingData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please save your changes before booking.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    // final bookingData = BookingProgramModel(
    //   programId: widget.programId,
    //   note: noteController.text.trim(),
    //   address: _userData?.address ?? 'Egypt',
    //   healthStatus: _userData?.healthStatus ?? 'Good',
    //   nationality: _userData?.nationality ?? 'Egypt',
    //   parentAddress: _userData?.parentAddress ?? 'Egypt',
    //   parentName: _userData?.parentName ?? 'Father',
    //   parentNationality: _userData?.parentNationality ?? 'Egypt',
    //   phoneNumber: _userData?.phoneNumber ?? '+201234567847',
    // );
    
    if (noteController.text.isEmpty || noteController.text.length <= 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Note must be more than 6 characters.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } // Validate the stored phone number
    String phoneNumber = _bookingData!.phoneNumber?.trim() ?? "";

    if (!RegExp(r'^\+\d{10,15}$').hasMatch(phoneNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid phone number format. Use +20XXXXXXXXXX'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Update the note in the saved booking data
    final updatedBookingData = _bookingData?.copyWith(
      // image: _paymentImage??'',
      note: noteController.text,

    );

      print("📤 Booking Data: $updatedBookingData");
    print("📸 Payment Image: ${_paymentImage ?? 'No Image'}");

    context.read<RequestsCubit>().bookProgram(updatedBookingData!, imageFile: _paymentImage);
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
                builder: (context) =>   NotFoundScreen(
                          svgPath: ImageManager.successfullyPurchased,
                          title: AppString.successfullyPurchased,
                        ),
              ),
            );
          } else if (state is RequestsError) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return BlocConsumer<UserDataCubit, UserDataState>(
            listener: (context, state) {
              if (state is UserDataSuccess) {
                setState(() => _userData = state.userModel);
                print('Userrrrr Data: $_userData');
              }
              
              if (state is UserDataFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
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
      child: CustomAppButton(text: AppString.book, onPressed: _handleBookProgram
          // ? () {
          //     _handleBookProgram();
          //   }
          // : () {
          //     // Show a message if the profile is incomplete
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //         content: Text('Please complete your profile to book the program.'),
          //         backgroundColor: Colors.red,
          //       ),
          //     );
          //   },
          ),
    );
  }
}
