import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/components/custom_app_bar.dart';
import 'package:hola_academy/core/components/custom_colored_outline_button.dart';
import 'package:hola_academy/features/not_found/not_found_screen.dart';

import '../../../core/constants/color_manager.dart';
import '../../home/UI/components/program_card.dart';
import '../Logic/programs/programs_cubit.dart';
import '../Logic/programs/programs_state.dart';
import 'Loading/details_classes_loading_screen.dart';

class DetailClassScreen extends StatelessWidget {
  final int programId;
  const DetailClassScreen({super.key, required this.programId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProgramsCubit, ProgramsState>(
        builder: (context, state) {
          if (state is ProgramsLoading) {
            return const DetailsClassesLoadingWidget();
          } else if (state is SingleProgramSuccess) {
            final program = state.program;
            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 260.h), // Leave space for the bottom widget
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomAppBar(
                              title: program.name,
                              isBack: true,
                              widget: CustomColoredOutlineButton(
                                radius: 25,
                                title: 'Book Now',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w300,
                                  color: ColorManager.primaryOrangeColor,
                                ),
                                height: 30.h,
                                width: 86.w,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.bookProgramsScreen,
                                    arguments: programId,
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: _buildProgramDetails(program),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white, // Background to separate from scroll
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: _buildProgramLevels(program),
                  ),
                ),
              ],
            );
          } else if (state is ProgramsError) {
            return Center(child: NotFoundScreen(title: state.message));
          } else {
            return NotFoundScreen(title: 'Program not found');
          }
        },
      ),
    );
  }

 Widget _buildProgramDetails(program) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Age Information (With Icons)
        Row(
          children: [
            Icon(Icons.cake, color: Colors.grey, size: 20.w),
            SizedBox(width: 8.w),
            Text(
              "Min Age: ${program.minAge}  |  Max Age: ${program.maxAge}",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.black87),
            ),
          ],
        ),

        SizedBox(height: 8.h),

        // Suitable Gender
        Row(
          children: [
            Icon(Icons.person, color: Colors.grey, size: 20.w),
            SizedBox(width: 8.w),
            Text(
              "Suitable For: ${program.allowedGender}",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.black87),
            ),
          ],
        ),

        SizedBox(height: 8.h),

        // Category
        Row(
          children: [
            Icon(Icons.category, color: Colors.grey, size: 20.w),
            SizedBox(width: 8.w),
            Text(
              "Category: ${program.category.name}",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.black87),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // Description Header
        Text(
          "Program Overview",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 6.h),

        // Description Text
        Text(
          program.description,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black54),
        ),
      ],
    ),
  );
}


  Widget _buildProgramLevels(program) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Programs Levels",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Color(0xff6C757D)),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 240.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: program.levels?.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 18.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.programlevlScreen,
                      arguments: program.levels?[index],
                    );
                  },
                  child: ProgramCard(
                    backgroundColor: Color(0xffF7E9E9),
                    text: program.levels?[index].name ?? "Level B",
                    height: 240.h,
                    width: 196.w,
                    color: Color(0xffAD2525),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  TextStyle boldStyle() {
    return TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Color(0xFF3C4146));
  }

  TextStyle normalStyle() {
    return TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF626A72));
  }
}
