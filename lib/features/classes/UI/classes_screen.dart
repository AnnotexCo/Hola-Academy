import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/components/custom_app_bar.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/features/classes/Logic/cubit/programs_state.dart';
import 'package:hola_academy/features/classes/UI/widgets/program_widget.dart';
import 'package:hola_academy/features/classes/UI/widgets/available_class_widget.dart';
import 'package:hola_academy/features/classes/UI/widgets/progress_class_widget.dart';
import 'package:hola_academy/features/classes/UI/widgets/tap_bar.dart';

import '../../../core/constants/app_string.dart';
import '../Logic/cubit/programs_cubit.dart';
import 'Loading/programs_loading_screen.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key});

  @override
  ClassesScreenState createState() => ClassesScreenState();
}

class ClassesScreenState extends State<ClassesScreen> {
  String selectedTab = "All Programs"; // Default selection

  void _onMenuSelected(String value) {
    setState(() {
      selectedTab = value;
    });
  }

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  context.read<ProgramsCubit>().fetchAllPrograms();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: BlocBuilder<ProgramsCubit, ProgramsState>(
        builder: (context, state) {
          if (state is ProgramsLoading) {
            return  ListView.builder(
              padding: EdgeInsets.only(top: 20.h),
              itemCount: 5, 
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 18.0.h),
                  child: ProgramShimmerWidget(), 
                );
              },
            );
          } else if (state is ProgramsSuccess) {
            final programs = state.programs;
            return Column(
            spacing: 15.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: AppString.programs,
                widget: PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.format_list_bulleted_rounded,
                      color: ColorManager.redMagmaColor),
                  borderRadius: BorderRadius.circular(12.r),
                  color: ColorManager.backgroundColor,
                  offset: Offset(-15, 40.h),
                  onSelected: _onMenuSelected,
                  itemBuilder: (context) => [
                    _buildMenuItem("My Classes"),
                    _buildMenuItem("Available"),
                    _buildMenuItem("All Programs"),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 32.w),
                child: Text(
                  selectedTab == "My Classes"
                      ? "Active"
                      : selectedTab == "Available"
                          ? "Available Classes"
                          : "All Programs",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.graycolorHeadline,
                  ),
                ),
              ),
              if (selectedTab == "All Programs")
                Padding(
                  padding: EdgeInsets.only(left: 32.w),
                  child: TapBar(),
                ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 5),
                  itemCount: programs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 18.0.h),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.detailsScreen);
                        },
                        child: selectedTab == "My Classes"
                            ? ProgressClassWidget()
                            : selectedTab == "Available"
                                ? AvailableClassWidget()
                                : ProgramWidget(program: programs[index]),
                      ),
                    );
                  },
                ),
              ),
              selectedTab == "My Classes"
                  ? Padding(
                      padding: EdgeInsets.only(left: 32.w),
                      child: Text(
                        "Completed",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.graycolorHeadline,
                        ),
                      ),
                    )
                  : SizedBox(),
              selectedTab == "My Classes"
                  ? Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 2),
                        itemCount: programs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 18.0.h),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.detailsScreen);
                              },
                              child: selectedTab == "My Classes"
                                  ? ProgressClassWidget()
                                  : selectedTab == "Available"
                                      ? AvailableClassWidget()
                                      : ProgramWidget(program: programs[index]),
                            ),
                          );
                        },
                      ),
                    )
                  : SizedBox()
            ],
          );
          }
          else if (state is ProgramsError) {
            return Center(child: Text(state.message));
          }
          else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }

  PopupMenuItem<String> _buildMenuItem(String value) {
    bool isSelected = selectedTab == value;

    return PopupMenuItem(
      height: 10.h,
      value: value,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.redMagmaColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          value,
          style: TextStyle(
            color: isSelected ? Colors.white : ColorManager.blackColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
