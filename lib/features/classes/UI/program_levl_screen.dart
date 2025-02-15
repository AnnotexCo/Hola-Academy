import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/components/custom_app_bar.dart';
import 'package:hola_academy/features/classes/UI/widgets/dynamic_program_levl_detail_widget.dart';

import '../Data/Model/programs_model.dart';

class ProgramLevlScreen extends StatelessWidget {
  final LevelModel level;

  const ProgramLevlScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 18.h,
          children: [
            CustomAppBar(
              title: level.name,
              // title: "Level A",
            ),
            ProgramLevlDetailWidget(
              level: level,
            )
          ],
        ),
      ),
    );
  }
}
