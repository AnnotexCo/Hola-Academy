import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/custom_app_button.dart';
import '../../../../core/components/general_text_form_field.dart';
import '../../../../core/components/title_widget.dart';
import '../../../../core/constants/app_string.dart';
import '../../../profile/Data/Model/user_model.dart';
import '../../Data/Model/booking_program_model.dart';
import '../widgets/parent_guardian_section.dart';

class AdditionalDetailsForBookingSection extends StatefulWidget {
  final int programId;
  final UserModel? userData; // Used only for pre-filling the form
  final Function(BookingProgramModel) onSavePressed;

  const AdditionalDetailsForBookingSection({
    super.key,
    required this.programId,
    required this.userData,
    required this.onSavePressed,
  });

  @override
  State<AdditionalDetailsForBookingSection> createState() =>
      _AdditionalDetailsForBookingSectionState();
}

class _AdditionalDetailsForBookingSectionState
    extends State<AdditionalDetailsForBookingSection> {
  late TextEditingController _nationalityController;
  late TextEditingController _addressController;
  late TextEditingController _healthStatusController;
  late TextEditingController _parentAddressController;
  late TextEditingController _parentNameController;
  late TextEditingController _parentNationalityController;
  late TextEditingController _phoneNumberController;
  // late TextEditingController _noteController;
  bool _hasHealthIssues = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    // Pre-fill the controllers with UserModel data (if available)
    _nationalityController =
        TextEditingController(text: widget.userData?.nationality ?? "");
    _addressController = TextEditingController(text: widget.userData?.address);
    _healthStatusController =
        TextEditingController(text: widget.userData?.healthStatus);
    _parentAddressController =
        TextEditingController(text: widget.userData?.parentAddress);
    _parentNameController =
        TextEditingController(text: widget.userData?.parentName);
    _parentNationalityController =
        TextEditingController(text: widget.userData?.parentNationality);
  _phoneNumberController = TextEditingController(
  text: widget.userData?.phoneNumber,
);

    // _noteController = TextEditingController();
    _hasHealthIssues = widget.userData?.healthStatus?.isNotEmpty ?? false;
  }

   void _saveProfileData() {
    // Create a BookingProgramModel instance with the updated data
    final bookingData = BookingProgramModel(
      programId: widget.programId,
      address: _addressController.text,
      nationality: _nationalityController.text,
      healthStatus: _hasHealthIssues ? _healthStatusController.text : null,
      parentAddress: _parentAddressController.text,
      parentName: _parentNameController.text,
      parentNationality: _parentNationalityController.text,
      phoneNumber: _phoneNumberController.text, 
      // note: _noteController.text,
    );

    // Pass the saved data back to the parent widget
    widget.onSavePressed(bookingData);

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Changes saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPersonalDetailsSection(),
        SizedBox(height: 32.h),
        buildParentGuardianSection(
          parentAddressController: _parentAddressController,
          parentNameController: _parentNameController,
          parentNationalityController: _parentNationalityController,
          phoneNumberController: _phoneNumberController,
        ),
        SizedBox(height: 32.h),
        CustomAppButton(
          text: 'Save Changes',
          onPressed: _saveProfileData,
        ),
      ],
    );
  }

  Widget _buildPersonalDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralTextFormField(
          label: AppString.yourNationality,
          hint: AppString.yourNationality,
          controller: _nationalityController,
          prefixIcon: GeneralTextFormField.createIcon(Icons.public),
          fillColor: const Color(0xFFFFF3F3),
        ),
        SizedBox(height: 16.h),
        GeneralTextFormField(
          label: AppString.yourAddress,
          hint: AppString.yourAddress,
          controller: _addressController,
          prefixIcon:
              GeneralTextFormField.createIcon(Icons.location_on_outlined),
          fillColor: const Color(0xFFFFF3F3),
        ),
        SizedBox(height: 16.h),
        _buildHealthStatusSection(),
      ],
    );
  }

  Widget _buildHealthStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleWidget(title: AppString.healthStatus),
        Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: _hasHealthIssues,
              onChanged: (v) => setState(() => _hasHealthIssues = v ?? false),
            ),
            Text(AppString.yes),
            SizedBox(width: 24.w),
            Radio<bool>(
              value: false,
              groupValue: _hasHealthIssues,
              onChanged: (v) => setState(() => _hasHealthIssues = v ?? false),
            ),
            Text(AppString.no),
          ],
        ),
        if (_hasHealthIssues)
          GeneralTextFormField(
            label: AppString.pleaseSpecify,
            hint: AppString.pleaseSpecify,
            controller: _healthStatusController,
          ),
      ],
    );
  }
}
