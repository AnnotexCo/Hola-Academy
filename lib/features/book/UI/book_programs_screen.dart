import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/app_string.dart';

import '../../../core/components/custom_app_bar.dart';
import '../../../core/components/custom_app_button.dart';
import '../../../core/components/general_text_form_field.dart';
import '../../../core/components/title_widget.dart';
import '../../../core/constants/image_manager.dart';
import '../../not_found/not_found_screen.dart';
import 'widgets/additional_notes_section.dart';
import 'widgets/parent_guardian_section.dart';
import 'widgets/payment_upload_section.dart';

class BookProgramScreen extends StatefulWidget {
  const BookProgramScreen({super.key});

  @override
  State<BookProgramScreen> createState() => _BookProgramScreenState();
}

class _BookProgramScreenState extends State<BookProgramScreen> {
  bool hasHealthIssues = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              title: AppString.bookProgram,
              onPressed: () {},
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  Center(
                      child: const TitleWidget(
                    title: AppString.additionalDetailsForBooking,
                    color: Color(0xff3B4045),
                  )),
                  SizedBox(height: 24.h),
                  buildPersonalDetailsSection(),
                  SizedBox(height: 32.h),
                  buildParentGuardianSection(),
                  SizedBox(height: 32.h),
                  buildAdditionalNotesSection(),
                  SizedBox(height: 32.h),
                  buildPaymentUploadSection(),
                  SizedBox(height: 32.h),
                  buildBookButton(),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget buildPersonalDetailsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GeneralTextFormField(
        label: AppString.yourNationality,
        hint: AppString.yourNationality,
        prefixIcon: GeneralTextFormField.createIcon(
          Icons.public,
        ),
        fillColor: const Color(0xFFFFF3F3),
      ),
      SizedBox(height: 16.h),
      GeneralTextFormField(
        label: AppString.yourAddress,
        hint: AppString.yourAddress,
        prefixIcon: GeneralTextFormField.createIcon(
          Icons.location_on_outlined,
        ),
        fillColor: const Color(0xFFFFF3F3),
      ),
      SizedBox(height: 16.h),
      buildHealthStatusSection(),
    ],
  );
}
Widget buildHealthStatusSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const TitleWidget(title: AppString.healthStatus),
      SizedBox(height: 8.h),
      Row(
        children: [
          buildRadioOption(
            AppString.yes,
            true,
            hasHealthIssues: hasHealthIssues,
            onChanged: (value) {
              setState(() {
                hasHealthIssues = value ?? false;
              });
            },
          ),
          SizedBox(width: 24.w),
          buildRadioOption(
            AppString.no,
            false,
            hasHealthIssues: hasHealthIssues,
            onChanged: (value) {
              setState(() {
                hasHealthIssues = value ?? false;
              });
            },
          ),
        ],
      ),
      SizedBox(height: 8.h),
      if (hasHealthIssues)
        GeneralTextFormField(
          label: '',
          hint: AppString.pleaseSpecify,
          fillColor: const Color(0xFFFFF3F3),
        ),
    ],
  );
}
Widget buildRadioOption(String label, bool value,
    {required bool hasHealthIssues,  required Function(bool?) onChanged}) {
  return Row(
    children: [
      Radio<bool>(
        value: value,
        groupValue: hasHealthIssues,
        activeColor: ColorManager.textRedColor,
        onChanged: onChanged,
      ),
      Text(
        label,
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.black87,
        ),
      ),
    ],
  );
}


  Widget buildBookButton() {
    return Center(
      child: CustomAppButton(
        text: AppString.book,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NotFoundScreen(
            svgPath: ImageManager.successfullyPurchased,
            title: AppString.successfullyPurchased,
          )));
          // Handle booking logic
        },
      ),
    );
  }
}
