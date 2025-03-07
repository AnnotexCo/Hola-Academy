import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/features/classes/Logic/lessons/cubit/lessons_cubit.dart';

import 'package:hola_academy/features/home/UI/components_coach/trainee_card.dart';
import 'package:hola_academy/features/profile/Data/Model/trainee_model.dart';

import '../../../../core/dependency_injection/dependency.dart';

class ListofTrainee extends StatelessWidget {
  final int classId;
  final String className;
  final  List<User> allUsersModel;

  const ListofTrainee({
    super.key,
    required this.allUsersModel,
    required this.classId, required this.className,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIT<LessonsCubit>(),
      child: Builder(
        builder: (context) {
          return ListView.builder(
            itemCount: allUsersModel.length,
            itemBuilder: (context, index) {
              var user = allUsersModel[index];
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 9.h,
                ),
                child: TraineeCard(
                  className: className,
                  userId: user.id,
                  name: user.name,
                  phone: user.phoneNumber,
                  image: user.profileImage!.path,
                  classId: classId,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
