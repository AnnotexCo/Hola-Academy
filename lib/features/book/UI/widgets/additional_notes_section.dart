import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/general_text_form_field.dart';
import '../../../../core/components/title_widget.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/constants/color_manager.dart';

  Widget buildAdditionalNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleWidget(title: AppString.additionalNotesTitle),
        GeneralTextFormField(
          label: '',
          hint: AppString.enterNotesHere,
          height: 107.h,
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          fillColor: ColorManager.backgroundLightPink,
          borderRadius: 20.r,
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 16.w,
          ),
        ),
      ],
    );
  }
