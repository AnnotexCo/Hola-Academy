import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/general_text_form_field.dart';
import '../../../../core/components/title_widget.dart';
import '../../../../core/constants/app_string.dart';


  Widget buildParentGuardianSection({
  required TextEditingController parentNameController,
  required TextEditingController parentNationalityController,
  required TextEditingController parentAddressController,
  required TextEditingController phoneNumberController,
}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleWidget(title: AppString.parentGuardianInformation),
        SizedBox(height: 16.h),
        GeneralTextFormField(
          controller: parentNameController,
          label: AppString.fullName,
          hint: AppString.fullName,
          prefixIcon: GeneralTextFormField.createIcon(
            Icons.person,
            size: 20.sp,
          ),
         
        ),
        SizedBox(height: 16.h),
        GeneralTextFormField(   
          controller: parentNationalityController,
          label: AppString.nationality,
          hint: AppString.nationality,
          prefixIcon: GeneralTextFormField.createIcon(
            Icons.public,
          ),
         
        ),
        SizedBox(height: 16.h),
        GeneralTextFormField(
          controller: parentAddressController,
          label: AppString.address,
          hint: AppString.address,
          prefixIcon: GeneralTextFormField.createIcon(
            Icons.location_on_outlined,
          ),
         
        ),
        // SizedBox(height: 16.h),
        // GeneralTextFormField(
        //   label: AppString.emailAddress,
        //   hint: AppString.enterYourEmail,
        //   prefixIcon: GeneralTextFormField.createIcon(
        //     Icons.email,
        //   ),
        //   keyboardType: TextInputType.emailAddress,
        // ),
        SizedBox(height: 16.h),
        GeneralTextFormField(
          controller: phoneNumberController,
          label: AppString.phoneNumber,
          hint: AppString.yourPhone,
          prefixIcon: GeneralTextFormField.createIcon(
            Icons.phone_outlined,
          ),
          keyboardType: TextInputType.phone,
         
        ),
      ],
    );
  }

