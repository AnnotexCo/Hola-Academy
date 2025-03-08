import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/components/custom_app_bar.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/features/classes/Data/Model/category_model.dart';
import 'package:hola_academy/features/classes/Logic/categories/categories_cubit.dart';
import 'package:hola_academy/features/classes/Logic/classes/cubit/classes_cubit.dart';
import 'package:hola_academy/features/classes/Logic/programs/programs_cubit.dart';
import 'package:hola_academy/features/classes/UI/widgets/available_class_widget.dart';
import 'package:hola_academy/features/classes/UI/widgets/progress_class_widget.dart';
import 'package:hola_academy/features/classes/UI/widgets/program_widget.dart';
import 'package:hola_academy/features/classes/UI/widgets/categories_tap_buttons.dart';
import 'package:hola_academy/features/classes/UI/widgets/shimmereffect.dart';
import 'package:hola_academy/features/not_found/not_found_screen.dart';

import '../Logic/categories/categories_state.dart';
import '../Logic/programs/programs_state.dart';

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
      selectedTab = ClassesTab.values.byName(value);
      selectedCategoryId = null;
    });

    if (selectedTab == ClassesTab.myClasses) {
      context.read<ClassesCubit>().getmyClass();
    } else if (selectedTab == ClassesTab.available) {
      context.read<ClassesCubit>().getAllClasses();
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<ProgramsCubit>().fetchAllPrograms();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProgramsCubit, ProgramsState>(
      listener: (context, state) {
        if (state is ProgramsError) {
          _showError(state.message);
        }
      },
      builder: (context, programsState) {
        return BlocConsumer<ClassesCubit, ClassesState>(
          listener: (context, state) {
            if (state is ClassesError) {
              _showError(state.error);
            }
          },
          builder: (context, classesState) {
            if (programsState is ProgramsLoading ||
                classesState is ClassesLoading) {
              return _buildLoadingState(); // Show shimmer while loading
            }

            if (programsState is ProgramsSuccess ||
                classesState is ClassesLoaded) {
              return _buildUI(programsState, classesState);
            }

            return SizedBox.shrink();
          },
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(),
          SizedBox(height: 12.h),
          _buildTabTitle(),
          _buildShimmerProgramsList(),
        ],
      ),
    );
  }

  Widget _buildShimmerProgramsList() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 5),
        itemCount: 5, // Placeholder for shimmer items
        itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(bottom: 18.h),
            child: AvailableClassWidgetShimmer()),
      ),
    );
  }

  Widget _buildUI(ProgramsState programsState, ClassesState classesState) {
    final allPrograms =
        (programsState is ProgramsSuccess) ? programsState.programs : [];
    final availableClasses =
        (classesState is ClassesLoaded) ? classesState.classes : [];
    final myClasses =
        (classesState is MyClassesLoaded) ? classesState.classes : [];

    final filteredPrograms =
        _getFilteredPrograms(allPrograms, availableClasses, myClasses);

    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(),
          SizedBox(height: 12.h),
          _buildTabTitle(),
          if (selectedTab == ClassesTab.allPrograms) _buildCategoryFilter(),
          _buildProgramsList(filteredPrograms),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return CustomAppBar(
      title: AppString.programs,
      isBack: false,
      widget: PopupMenuButton<String>(
        offset: Offset(-15, 40.h),
        color: ColorManager.whiteColor,
        icon: Icon(Icons.format_list_bulleted_rounded,
            color: ColorManager.redMagmaColor),
        itemBuilder: (context) => [
          _buildMenuItem(ClassesTab.allPrograms.name, "All Programs"),
          _buildMenuItem(ClassesTab.available.name, "Available"),
          _buildMenuItem(ClassesTab.myClasses.name, "My Classes"),
        ],
        onSelected: _onMenuSelected,
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
    const titles = {
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
            color: ColorManager.grayColorHeadline),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          final List<CategoryModel> categories =
              (state is CategoriesSuccess) ? state.categories : [];
          return CategoryFilterButtons(
            categories: categories,
            onCategorySelected: (id) => setState(() => selectedCategoryId = id),
            selectedCategoryId: selectedCategoryId,
          );
        },
      ),
    );
  }

  Widget _buildProgramsList(List filteredPrograms) {
    return Expanded(
      child: filteredPrograms.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.only(top: 5),
              itemCount: filteredPrograms.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(bottom: 18.h),
                child: _buildClassItem(filteredPrograms[index]),
              ),
            )
          : NotFoundScreen(
              title: "There is no programs yet!",
            ),
    );
  }

  Widget _buildClassItem(dynamic program) {
    switch (selectedTab) {
      case ClassesTab.myClasses:
        return ProgressClassWidget(
          myClassModel: program,
        );
      case ClassesTab.available:
        return AvailableClassWidget(
          model: program,
        );
      default:
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, Routes.detailsScreen,
              arguments: program.id),
          child: ProgramWidget(program: program),
        );
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

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
