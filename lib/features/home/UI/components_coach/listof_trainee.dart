import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hola_academy/features/home/UI/components_coach/trainee_card.dart';
import 'package:hola_academy/features/profile/Data/Model/trainee_model.dart';

class ListofTrainee extends StatelessWidget {
  final int classId;
  final AllUsersModel allUsersModel;

  const ListofTrainee({
    super.key,
    required this.allUsersModel, required this.classId,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allUsersModel.data.users.length,
      itemBuilder: (context, index) {
        var user = allUsersModel.data.users[index];
        return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 9.h,
            ),
            child: TraineeCard(
              classId: classId,
                name: user.name,
                phone: user.phoneNumber,
                image: user.profileImage!.path));
      },
    );
  }
}
