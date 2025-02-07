import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/components/custom_dialog.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/trainee/widgets/feedback_dialog.dart';

class EvaluateDialog extends StatelessWidget {
  final String traineeName;
  final String courseTitle;
  final String imageUrl;
  final VoidCallback onCancel;

  const EvaluateDialog(
      {super.key,
      required this.traineeName,
      required this.courseTitle,
      required this.imageUrl,
      required this.onCancel});

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
                  AppString.skills,
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
                    itemCount: skills.length,
                    itemBuilder: (context, index) {
                      return BuildSkillsItem(
                        skillName: skills[index]['name'],
                        rating: skills[index]['rating'],
                        onChanged: (value) {
                          skills[index]['rating'] = value;
                        },
                        onTap: () {
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return FeedbackDialog(
                                imageUrl: ImageManager.pic,
                                traineeName: 'Robert Fox',
                                courseTitle: 'Basic Swimming Techniques',
                                techniqueTitle: skills[index]['name'],
                                onSave: () {
                                  // Handle save action
                                  Navigator.of(context).pop();
                                },
                                onCancel: () {
                                  // Handle cancel action
                                  Navigator.of(context).pop();
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return EvaluateDialog(
                                        imageUrl: ImageManager.pic,
                                        traineeName: 'Robert Fox',
                                        courseTitle:
                                            'Basic Swimming Techniques',
                                        onCancel: () {
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    },
                                  );
                                },
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

List<Map<String, dynamic>> skills = [
  {
    'name': AppString.armStrokeTechnique,
    'rating': 0.0,
  },
  {
    'name': AppString.legKickCoordination,
    'rating': 1.0,
  },
  {
    'name': AppString.breathingPatternConsistency,
    'rating': 1.0,
  },
  {
    'name': AppString.headPosition,
    'rating': 1.0,
  },
  {
    'name': AppString.coreStabilityWhileFloating,
    'rating': 0.0,
  },
];

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
/*

*/
