import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/classes/Logic/lessons/cubit/lessons_cubit.dart';
import 'package:hola_academy/features/trainee/widgets/lessons_dialog.dart';

import '../../../../core/constants/api_constants.dart';

class TraineeCard extends StatelessWidget {
  final String className;
  final int classId;
  final String? name;
  final String? phone;
  final String? image;
  final int? userId;
  const TraineeCard(
      {this.name,
      this.phone,
      super.key,
      required this.image,
      required this.classId,
      required this.userId,
      required this.className});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 71.h,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4F4),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: const Color(0xFFD32F2F),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: CachedNetworkImage(
              imageUrl: "${ApiConstants.imagesURLApi}${image!}",
              errorWidget: (context, url, error) => Image.asset(
                ImageManager
                    .programImage, // Default image path // Default image path
                width: 35.w,
                height: 35.h,
              ),
              width: 50.w,
              height: 50.h,
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: 'Name: ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.textRedColor,
                    ),
                    children: [
                      TextSpan(
                        text: name ?? 'Robert Fox',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.graycolorHeadline,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: 'Phone Number: ',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.textRedColor,
                    ),
                    children: [
                      TextSpan(
                        text: phone ?? "010815121512",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.graycolorHeadline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24.h,
            width: 80.w,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(const Color(0xffF09C1F)),
                padding:
                    WidgetStateProperty.all(EdgeInsets.zero), // Removes padding
                tapTargetSize:
                    MaterialTapTargetSize.shrinkWrap, // Removes extra margin
              ),
              onPressed: () {
                final lessonsCubit = context.read<LessonsCubit>();
                lessonsCubit.getLessonsByID(userId!, classId);

                showDialog(
                    context: context,
                    builder: (context) {
                      return BlocProvider.value(
                        value: lessonsCubit,
                        child: BlocConsumer<LessonsCubit, LessonsState>(
                          listener: (context, state) {
                            if (state is LessonsSuccess) {}
                          },
                          builder: (context, state) {
                            if (state is LessonsSuccess) {
                              return LessonsDialog(
                                lessons: state.lessons,
                                imageUrl: image!,
                                traineeName: name!,
                                courseTitle: className,
                                onCancel: () {
                                  Navigator.of(context).pop();
                                },
                              );
                            }
                            return SizedBox.shrink();
                          },
                        ),
                      );
                    });
              },
              child: Text(
                "Evaluate",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: ColorManager.backgroundColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
