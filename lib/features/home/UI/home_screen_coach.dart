import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/components/calender_widget.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/classes/Logic/categories/categories_cubit.dart';
import 'package:hola_academy/features/classes/Logic/categories/categories_state.dart';
import 'package:hola_academy/features/home/UI/components/add_baner.dart';

import 'package:hola_academy/features/home/UI/components/timeline_widget.dart';
import 'package:hola_academy/features/home/UI/components/welcome_header.dart';
import 'package:hola_academy/features/home/UI/components_coach/classes_dialog.dart';
import 'package:hola_academy/features/home/UI/components_coach/evaluate_card.dart';
import 'package:hola_academy/features/home/UI/components_coach/session_card.dart';
import 'package:hola_academy/features/profile/Logic/personal_info/user_data_cubit.dart';
import 'package:hola_academy/features/trainee/widgets/evaluate_dialog.dart';

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
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return EvaluateDialog(
                            imageUrl: ImageManager.pic,
                            traineeName: 'Robert Fox',
                            courseTitle: 'Basic Swimming Techniques',
                            onCancel: () {
                              Navigator.of(context).pop();
                            },
                          );
                        });
                  },
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
                                        showDialog(
                                          context: context,
                                          builder: (_) {
                                            return ClassesDialog(
                                              title: "Educational",
                                              onCancel: () =>
                                                  Navigator.pop(context),
                                              options: [
                                                {
                                                  "title": "Private",
                                                  "icon":
                                                      ImageManager.privateclass
                                                },
                                                {
                                                  "title": "SemiPrivate",
                                                  "icon": ImageManager
                                                      .semiprivateclass
                                                },
                                                {
                                                  "title": "Aqua",
                                                  "icon": ImageManager.aquaclass
                                                },
                                                {
                                                  "title": "Kids",
                                                  "icon": ImageManager.kidsclass
                                                },
                                              ],
                                              onOptionSelected: (selected) {
                                                if (selected == "Private") {
                                                  showPrivateLevelsDialog(
                                                      context);
                                                }
                                              },
                                            );
                                          },
                                        );
                                      },
                                      child: EvaluateCard(
                                        backgroundImage: state.categories[index]
                                            .image!.path, //ImageManager.pic,
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

void showPrivateLevelsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return ClassesDialog(
        title: "Private Levels",
        onCancel: () => Navigator.pop(context),
        options: [
          {"title": "Level A", "icon": ImageManager.privateclass},
          {"title": "Level B", "icon": ImageManager.semiprivateclass},
          {"title": "Level C", "icon": ImageManager.kidsclass},
          {"title": "Level D", "icon": ImageManager.aquaclass},
        ],
        onOptionSelected: (selectedLevel) {
          if (selectedLevel == "Level A") {
            showClassifcationDialog(context, selectedLevel);
          }
        },
      );
    },
  );
}

void showClassifcationDialog(BuildContext context, String levl) {
  showDialog(
    context: context,
    builder: (_) {
      return ClassesDialog(
        title: levl,
        onCancel: () => Navigator.pop(context),
        options: [
          {
            "title": "Beginner Swimming Class",
            "icon": ImageManager.privateclass
          },
          {
            "title": "Intermediate Swimming Class",
            "icon": ImageManager.semiprivateclass
          },
          {"title": "Aqua Fitness Class", "icon": ImageManager.aquaclass},
          {
            "title": "Open Water Swimming Class",
            "icon": ImageManager.semiprivateclass
          },
          {"title": "Kids Swimming Class", "icon": ImageManager.kidsclass},
        ],
        onOptionSelected: (selectedLevel) {
          if (selectedLevel == "Beginner Swimming Class") {
            Navigator.pushNamed(context, Routes.findTraineeScreen);
          }
        },
      );
    },
  );
}
