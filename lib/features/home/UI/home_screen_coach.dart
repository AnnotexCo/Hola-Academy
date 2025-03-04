import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/app_router.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/components/calender_widget.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/features/classes/Logic/categories/categories_cubit.dart';
import 'package:hola_academy/features/classes/Logic/categories/categories_state.dart';
import 'package:hola_academy/features/classes/Logic/classes/cubit/classes_cubit.dart';
import 'package:hola_academy/features/classes/Logic/levels/cubit/levels_cubit.dart';
import 'package:hola_academy/features/classes/Logic/programms/programs_cubit.dart';
import 'package:hola_academy/features/classes/Logic/programms/programs_state.dart';
import 'package:hola_academy/features/home/UI/components/add_baner.dart';
import 'package:hola_academy/features/home/UI/components/timeline_widget.dart';
import 'package:hola_academy/features/home/UI/components/welcome_header.dart';
import 'package:hola_academy/features/home/UI/components_coach/classes_dialog.dart';
import 'package:hola_academy/features/home/UI/components_coach/evaluate_card.dart';
import 'package:hola_academy/features/home/UI/components_coach/session_card.dart';
import 'package:hola_academy/features/not_found/not_found_screen.dart';
import 'package:hola_academy/features/profile/Logic/personal_info/user_data_cubit.dart';
import '../../../core/dependency_injection/dependency.dart';
import '../Logic/banner_logic/banner_cubit.dart';

class HomeScreenCoach extends StatelessWidget {
  const HomeScreenCoach({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0.w),
          child: SingleChildScrollView(
            child: Column(
              spacing: 18.h,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 13.h,
                ),
                BlocProvider(
                  create: (context) => getIT<UserDataCubit>()..getMyData(),
                  child: Align(
                      alignment: Alignment.centerLeft, child: WelcomeHeader()),
                ),
                GestureDetector(
                  onTap: () {},
                  child: BlocProvider(
                    create: (context) =>
                        getIT<BannersCubit>()..fetchAllBanners(),
                    child: AddBaner(),
                  ),
                ),
                SizedBox(
                  height: 80.h,
                  width: double.infinity,
                  child: TimelineWidget(),
                ),
                SessionReminderCard(
                  title: "You Have a Swimming Level A Session On Monday",
                  time: "5:00 PM",
                ),
                SizedBox(
                  height: 300.h,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 18.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Evaluate Students",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff6C757D),
                          )),
                      BlocProvider(
                        create: (context) =>
                            getIT<CategoriesCubit>()..fetchAllCategories(),
                        child: BlocBuilder<CategoriesCubit, CategoriesState>(
                          builder: (context, state) {
                            if (state is CategoriesSuccess) {
                              return SizedBox(
                                height: 245.h,
                                width: double.infinity,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.categories.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        final programsCubit =
                                            context.read<ProgramsCubit>();
                                        final levelsCubit =
                                            context.read<LevelsCubit>();

                                        final classesCubit =
                                            context.read<ClassesCubit>();
                                        showDialog(
                                          context: context,
                                          builder: (_) {
                                            String categoryName =
                                                state.categories[index].name;
                                            // TODO Get Programs by Category ID
                                            return BlocProvider.value(
                                              value: programsCubit,
                                              child: BlocBuilder<ProgramsCubit,
                                                  ProgramsState>(
                                                builder: (context, state) {
                                                  if (state
                                                      is ProgramsSuccess) {
                                                    final options = state
                                                        .programs
                                                        .map((program) => {
                                                              "title":
                                                                  program.name,
                                                              "icon": program
                                                                  .image
                                                                  ?.path, // Handle null image safely
                                                            })
                                                        .toList();

                                                    return ClassesDialog(
                                                      title: categoryName,
                                                      onCancel: () =>
                                                          Navigator.pop(
                                                              context),
                                                      options: options,
                                                      onOptionSelected:
                                                          (selectedTitle) {
                                                        // Find the program that matches the selected title
                                                        final selectedProgram =
                                                            state.programs
                                                                .firstWhere(
                                                          (program) =>
                                                              program.name ==
                                                              selectedTitle,
                                                        );

                                                        if (selectedTitle ==
                                                            selectedProgram
                                                                .name) {
                                                          showPrivateLevelsDialog(
                                                              context,
                                                              levelsCubit,
                                                              classesCubit,
                                                              selectedProgram
                                                                  .id,
                                                              selectedTitle);
                                                        }
                                                      },
                                                    );
                                                  }

                                                  if (state is ProgramsError) {
                                                    return NotFoundScreen();
                                                  }

                                                  if (state
                                                      is ProgramsLoading) {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator()); // Centered loading
                                                  }

                                                  return SizedBox.shrink();
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: EvaluateCard(
                                        backgroundImage: state.categories[index]
                                            .image!.path,
                                        title: state.categories[index].name,
                                      ),
                                    );
                                  },
                                  //SizedBox(width: 18.w,),
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                CalendarWidget(),
                SizedBox(
                  height: 13.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showPrivateLevelsDialog(BuildContext context, LevelsCubit levelsCubit,
    ClassesCubit classesCubit, int programId, String programName) {
  levelsCubit.fetchLevelsbyID(programId);
  showDialog(
    context: context,
    builder: (_) {
      return BlocProvider.value(
        value: levelsCubit,
        child: BlocBuilder<LevelsCubit, LevelsState>(
          builder: (context, state) {
            if (state is LevelsSuccess) {
              final options = state.levels
                  .map((level) => {
                        "title": level.name,
                        "icon": level.image?.path, // Handle null image safely
                      })
                  .toList();

              return ClassesDialog(
                title: "$programName Levels",
                onCancel: () => Navigator.pop(context),
                options: options,
                onOptionSelected: (selectedTitle) {
                  // Find the program that matches the selected title
                  final selectedProgram = state.levels.firstWhere(
                    (level) => level.name == selectedTitle,
                  );

                  if (selectedTitle == selectedProgram.name) {
                    showClassifcationDialog(context, classesCubit,
                        selectedProgram.id, selectedProgram.name);
                  }
                },
              );
            } else if (state is LevelsError) {
              print(state.message);
            }
            return SizedBox.shrink();
          },
        ),
      );
    },
  );
}

void showClassifcationDialog(BuildContext context, ClassesCubit classesCubit,
    int levelId, String levelName) {
  classesCubit.getAllClassesbyLevelId(levelId);

  print("$levelId Levlsl");
  showDialog(
    context: context,
    builder: (_) {
      return BlocProvider.value(
          value: classesCubit,
          child: BlocBuilder<ClassesCubit, ClassesState>(
            builder: (context, state) {
              if (state is ClassesLoaded) {
                final options = state.classes
                    .map((level) => {
                          "title": level.name,
                          "icon": level.imageUrl, // Handle null image safely
                        })
                    .toList();

                return ClassesDialog(
                  title: "$levelName ",
                  onCancel: () => Navigator.pop(context),
                  options: options,
                  onOptionSelected: (selectedTitle) {
                    // Find the program that matches the selected title
                    final selectedclass = state.classes.firstWhere(
                      (level) => level.name == selectedTitle,
                    );

                    if (selectedTitle == selectedclass.name) {
                      Navigator.pushNamed(
                        context,
                        Routes.findTraineeScreen,
                        arguments: ClassDetails(
                            name: selectedclass.name, id: selectedclass.id),
                      );
                    }
                  },
                );
              } else if (state is ClassesError) {}
              return SizedBox.shrink();
            },
          ));
    },
  );
}
