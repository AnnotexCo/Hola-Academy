import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hola_academy/features/home/components_coach/trainee_card.dart';


class ListofTrainee extends StatelessWidget {
 

  const ListofTrainee({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
     
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 9.h,
          ),
          child: TraineeCard()
        );
      },
    );
  }
}
