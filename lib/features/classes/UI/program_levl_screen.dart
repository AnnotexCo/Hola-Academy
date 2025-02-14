import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/components/custom_app_bar.dart';
import 'package:hola_academy/features/classes/UI/widgets/dynamic_program_levl_detail_widget.dart';

class ProgramLevlScreen extends StatelessWidget {
  const ProgramLevlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 18.h,
          children: [
            CustomAppBar(
              title: "Level A",
            ),
            ProgramLevlDetailWidget()
          ],
        ),
      ),
    );
  }
}
