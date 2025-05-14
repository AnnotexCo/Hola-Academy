import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/general_text_form_field.dart';
import '../../../../core/components/title_widget.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/constants/color_manager.dart';

Widget buildAdditionalNotesSection(
    {required TextEditingController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const TitleWidget(title: AppString.additionalNotesTitle),
      GeneralTextFormField(
        controller: controller,
        label: '',
        hint: AppString.enterNotesHere,
        height: 107.h,
        keyboardType: TextInputType.multiline,
        maxLines: 5, // Allow up to 5 lines
        minLines: 4, // Minimum of 4 lines
        fillColor: ColorManager.backgroundPinkColor,
        borderRadius: 20.r,
        contentPadding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 16.w,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some notes.';
          }
          if (value.length <= 6) {
            return 'Note must be more than 6 characters.';
          }
          return null;
        },
      ),
    ],
  );
}
