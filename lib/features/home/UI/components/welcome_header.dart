import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/features/home/UI/components/profile_pic_widget.dart';
import 'package:hola_academy/features/profile/Logic/personal_info/user_data_cubit.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        String name = " ";
        String pic = '';
        if (state is UserDataSuccess) {
          name = state.userModel.name;
          pic = state.userModel.profileImage?.path ?? '';
        }
        return SizedBox(
          height: 55.h,
          width: 188.w,
          child: Row(
            children: [
              ProfilePicWidget(
                height: 50,
                width: 50,
                pic: pic,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back!",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    name,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
