import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/components/custom_app_bar.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/features/classes/Data/Model/category_model.dart';
import 'package:hola_academy/features/classes/Logic/categories/categories_cubit.dart';
import 'package:hola_academy/features/classes/Logic/categories/categories_state.dart';
import 'package:hola_academy/features/classes/Logic/classes/cubit/classes_cubit.dart';
import 'package:hola_academy/features/classes/Logic/programms/programs_cubit.dart';
import 'package:hola_academy/features/classes/Logic/programms/programs_state.dart';
import 'package:hola_academy/features/classes/UI/widgets/available_class_widget.dart';
import 'package:hola_academy/features/classes/UI/widgets/progress_class_widget.dart';
import 'package:hola_academy/features/classes/UI/widgets/program_widget.dart';
import 'package:hola_academy/features/classes/UI/widgets/categories_tap_buttons.dart';
import 'package:hola_academy/features/not_found/not_found_screen.dart';

enum ClassesTab { allPrograms, available, myClasses }

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key});

  @override
  ClassesScreenState createState() => ClassesScreenState();
}

class ClassesScreenState extends State<ClassesScreen> {
  ClassesTab selectedTab = ClassesTab.allPrograms;
  int? selectedCategoryId;

  void _onMenuSelected(String value) {
    setState(() {
      selectedTab = ClassesTab.values.firstWhere(
        (e) => e.toString().split('.').last == value,
        orElse: () => ClassesTab.allPrograms,
      );
      selectedCategoryId = null;
    });

    if (selectedTab == ClassesTab.myClasses) {
      context.read<ClassesCubit>().getmyClass();
    }

    if (selectedTab == ClassesTab.available) {
      context.read<ClassesCubit>().getAllClasses();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProgramsCubit, ProgramsState>(
          listener: (context, state) {
            if (state is ProgramsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
        ),
        BlocListener<ClassesCubit, ClassesState>(
          listener: (context, state) {
            if (state is ClassesError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<ProgramsCubit, ProgramsState>(
        builder: (context, programsState) {
          return BlocBuilder<ClassesCubit, ClassesState>(
            builder: (context, classesState) {
              return _buildUI(programsState, classesState);
            },
          );
        },
      ),
    );
  }

  Widget _buildUI(ProgramsState programsState, ClassesState classesState) {
    final allPrograms =
        programsState is ProgramsSuccess ? programsState.programs : [];
    final availableClasses =
        classesState is ClassesLoaded ? classesState.classes : [];
    final myClasses =
        classesState is MyClassesLoaded ? classesState.classes : [];

    List filteredPrograms =
        _getFilteredPrograms(allPrograms, availableClasses, myClasses);

    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            title: AppString.programs,
            isBack: false,
            widget: PopupMenuButton<String>(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.format_list_bulleted_rounded,
                  color: ColorManager.redMagmaColor),
              borderRadius: BorderRadius.circular(12.r),
              color: ColorManager.backgroundColor,
              offset: Offset(-15, 40.h),
              onSelected: _onMenuSelected,
              itemBuilder: (context) => [
                _buildMenuItem(ClassesTab.allPrograms.name, "All Programs"),
                _buildMenuItem(ClassesTab.available.name, "Available"),
                _buildMenuItem(ClassesTab.myClasses.name, "My Classes"),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          _buildTabTitle(),
          if (selectedTab == ClassesTab.allPrograms) _buildCategoryFilter(),
          filteredPrograms.isNotEmpty
              ? _buildProgramsList(filteredPrograms)
              : NotFoundScreen(),
          // if (selectedTab == ClassesTab.myClasses)
          //   _buildCompletedClasses(filteredPrograms),
        ],
      ),
    );
  }

  List _getFilteredPrograms(
      List allPrograms, List availableClasses, List myClasses) {
    switch (selectedTab) {
      case ClassesTab.allPrograms:
        return selectedCategoryId == null
            ? allPrograms
            : allPrograms
                .where((p) => p.category.id == selectedCategoryId)
                .toList();
      case ClassesTab.available:
        return availableClasses;
      case ClassesTab.myClasses:
        return myClasses;
    }
  }

  Widget _buildTabTitle() {
    final titles = {
      ClassesTab.myClasses: "Active",
      ClassesTab.available: "Available Classes",
      ClassesTab.allPrograms: "All Programs",
    };
    return Padding(
      padding: EdgeInsets.only(left: 32.w),
      child: Text(
        titles[selectedTab]!,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: ColorManager.graycolorHeadline,
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          List<CategoryModel> categories =
              state is CategoriesSuccess ? state.categories : [];
          return CategoryFilterButtons(
            categories: categories,
            onCategorySelected: (categoryId) {
              setState(() {
                selectedCategoryId = categoryId;
              });
            },
            selectedCategoryId: selectedCategoryId,
          );
        },
      ),
    );
  }

  Widget _buildProgramsList(List filteredPrograms) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 5),
        itemCount: filteredPrograms.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(bottom: 18.0.h),
          child: _buildClassItem(filteredPrograms[index]),
        ),
      ),
    );
  }

  Widget _buildClassItem(dynamic program) {
    switch (selectedTab) {
      case ClassesTab.myClasses:
        return ProgressClassWidget(
            name: program.name,
            description: program.description,
            compelation: program.completion);
      case ClassesTab.available:
        return AvailableClassWidget(
            name: program.name, description: program.description);
      default:
        return GestureDetector(
            onTap: () => Navigator.pushNamed(context, Routes.detailsScreen,
                arguments: program.id),
            child: ProgramWidget(program: program));
    }
  }

  // Widget _buildCompletedClasses(List filteredPrograms) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.only(left: 32.w),
  //         child: Text(
  //           "Completed",
  //           style: TextStyle(
  //             fontSize: 18.sp,
  //             fontWeight: FontWeight.w600,
  //             color: ColorManager.graycolorHeadline,
  //           ),
  //         ),
  //       ),
  //       Expanded(
  //         child: ListView.builder(
  //           padding: EdgeInsets.only(top: 2),
  //           itemCount: filteredPrograms.length,
  //           itemBuilder: (context, index) => Padding(
  //             padding: EdgeInsets.only(bottom: 18.0.h),
  //             child: ProgressClassWidget(),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  PopupMenuItem<String> _buildMenuItem(String value, String name) {
    bool isSelected = selectedTab.name == value;
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
          name,
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
