import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/components/custom_dialog.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/features/classes/Data/Model/lessons_model.dart';
import 'package:hola_academy/features/classes/Logic/skills/cubit/skills_cubit.dart';
import 'package:hola_academy/features/trainee/widgets/evaluate_dialog.dart';
import 'package:intl/intl.dart';

class LessonsDialog extends StatelessWidget {
  final SkillsCubit skillsCubit;
  final String traineeName;
  final String courseTitle;
  final String imageUrl;
  final VoidCallback onCancel;
  final List<LessonModel> lessons;

  const LessonsDialog(
      {super.key,
      required this.traineeName,
      required this.courseTitle,
      required this.imageUrl,
      required this.onCancel,
      required this.lessons,
      required this.skillsCubit});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
        title: traineeName,
        imageUrl: imageUrl,
        onCancel: onCancel,
        components: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Titles
              Text(
                courseTitle,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.errorRedColor,
                ),
              ),
              SizedBox(height: 40.h),
              // Evaluation Form
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Lessons",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.textRedColor,
                  ),
                ),
                SizedBox(height: 25.h),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: lessons.length,
                    itemBuilder: (context, index) {
                      return BuildSkillsItem(
                        skillName: DateFormat('MMM dd, yyyy, hh:mm a')
                            .format(lessons[index].date),
                        rating:
                            lessons[index].lessonEvaluationCount!.toDouble(),
                        onChanged: (value) {
                          Navigator.of(context).pop();
                        },
                        onTap: () {
                          skillsCubit.getSkillsByLessonID(lessons[index].id);
                          Navigator.pop(context);

                          showDialog(
                            context: context,
                            builder: (context) {
                              return BlocProvider.value(
                                value: skillsCubit,
                                child: BlocConsumer<SkillsCubit, SkillsState>(
                                  listener: (context, state) {
                                    if (state is SkillsError) {
                                      Text('something went wrong');
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is SkillsLoaded) {
                                      return EvaluateDialog(
                                          lessonId: lessons[index].id,
                                          skillsCubit: skillsCubit,
                                          skills: state.skills,
                                          traineeName: traineeName,
                                          courseTitle: courseTitle,
                                          imageUrl: imageUrl,
                                          onCancel: () {
                                            Navigator.of(context).pop();
                                          });
                                    }

                                    return const SizedBox();
                                  },
                                ),
                              );
                            },
                          );
                        },
                      );
                    }),
              ]),
            ],
          ),
        ]);
  }
}

class BuildSkillsItem extends StatelessWidget {
  final String skillName;
  final double rating;
  final ValueChanged<double> onChanged;
  final void Function()? onTap;

  const BuildSkillsItem(
      {super.key,
      required this.skillName,
      required this.rating,
      required this.onChanged,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Container(
          width: 356.w,
          height: 41.h,
          decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              width: 1,
              style: BorderStyle.none,
            ),
          ),
          child: Row(
            children: [
              SizedBox(width: 21.w),
              Text(skillName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.itemRedColor,
                  )),
              Spacer(),
              Container(
                width: 34.w,
                height: 26.h,
                decoration: BoxDecoration(
                  color: ColorManager.whiteColor,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    width: 1,
                    color: ColorManager.softGrey,
                  ),
                ),
                child: Center(
                    child: Icon(Icons.star,
                        size: 20.w,
                        color: rating > 0
                            ? ColorManager.primaryOrangeColor
                            : ColorManager.lightGreyForFontColor)),
              ),
              SizedBox(width: 13.w),
            ],
          ),
        ),
      ),
    );
  }
}
