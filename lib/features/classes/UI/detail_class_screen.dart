import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/components/custom_app_bar.dart';
import 'package:hola_academy/core/components/custom_colored_outline_button.dart';
import 'package:hola_academy/features/home/components/program_card.dart';
import 'package:hola_academy/features/not_found/not_found_screen.dart';

import '../../../core/constants/color_manager.dart';
import '../Logic/cubit/programs_cubit.dart';
import '../Logic/cubit/programs_state.dart';
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
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                    title: program.name,
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
                        Navigator.pushNamed(context, Routes.bookProgramsScreen);
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: _buildProgramDetails(program),
                  ),
                  SizedBox(height: 50.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: _buildProgramLevels(program),
                  ),
                ],
              ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Lessons: 12\n\n',
                style: _boldStyle(),
              ),
              TextSpan(
                text: "General Description:\n\n",
                style: _boldStyle(),
              ),
              TextSpan(
                text: program.description,
                style: _normalStyle(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgramLevels(program) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Programs Levels",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xff6C757D),
          ),
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
                    text: program.levels?[index].name ?? "Level A",
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

  TextStyle _boldStyle() {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: Color(0xFF3C4146),
    );
  }

  TextStyle _normalStyle() {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: Color(0xFF626A72),
    );
  }
}
