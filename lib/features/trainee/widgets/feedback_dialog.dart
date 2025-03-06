import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/components/custom_colored_outline_button.dart';
import 'package:hola_academy/core/components/custom_dialog.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/features/classes/Logic/skills/cubit/skills_cubit.dart';

class FeedbackDialog extends StatelessWidget {
  final int lessonId;
  final int skilledId;
  final SkillsCubit skillsCubit;
  final String traineeName;
  final String courseTitle;
  final String techniqueTitle;
  final String imageUrl;

  const FeedbackDialog({
    super.key,
    required this.traineeName,
    required this.courseTitle,
    required this.techniqueTitle,
    required this.imageUrl,
    required this.skillsCubit,
    required this.lessonId,
    required this.skilledId,
  });

  @override
  Widget build(BuildContext context) {
    double rating = 0;
    bool isPassed = false;
    TextEditingController feedbackController = TextEditingController();

    return CustomDialog(
        title: traineeName,
        onCancel: () {
          Navigator.of(context).pop();
        },
        imageUrl: imageUrl,
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
              Text(
                techniqueTitle,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.textRedColor,
                ),
              ),
              SizedBox(height: 53.h),
              // Rating Bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Score:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.grayColorHeadline,
                    ),
                  ),
                  SizedBox(height: 18.h),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 10,
                    itemSize: 18.w,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: ColorManager.primaryOrangeColor,
                    ),
                    onRatingUpdate: (value) {
                      rating = value;
                      if (rating >= 7) {
                        isPassed = true;
                      } else {
                        isPassed = false;
                      }
                    },
                  ),
                  SizedBox(height: 25.h),

                  // Feedback Text Field
                  const Text(
                    AppString.feedback,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.grayColorHeadline,
                    ),
                  ),
                  SizedBox(height: 18.h),
                  TextField(
                    controller: feedbackController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ColorManager.whiteColor,
                      hintText: AppString.feedbackHint,
                      hintStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorManager.lightGreyForFontColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 11.h),
                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          skillsCubit.evaluateSkill(
                            lessonId,
                            skilledId,
                            rating.toInt(),
                            isPassed,
                            feedbackController.text,
                          );
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 120.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: ColorManager.primaryOrangeColor,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Center(
                            child: Text(
                              AppString.save,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: ColorManager.whiteColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      CustomColoredOutlineButton(
                          width: 120.w,
                          height: 30.h,
                          radius: 15.r,
                          title: AppString.cancel,
                          backgroundColor: Colors.transparent,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: ColorManager.primaryOrangeColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                          onTap: () {}),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ]);
  }
}
