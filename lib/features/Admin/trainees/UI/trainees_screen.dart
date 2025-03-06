import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/components/general_text_form_field.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/not_found/not_found_screen.dart';
import 'package:hola_academy/features/profile/Data/Model/trainee_model.dart';

import 'package:hola_academy/features/profile/Logic/personal_info/user_data_cubit.dart';
import 'widgets/custom_list_view.dart';

class TraineesScreen extends StatefulWidget {
  final String role;
  const TraineesScreen({super.key, required this.role});

  @override
  State<TraineesScreen> createState() => _TraineesScreenState();
}

class _TraineesScreenState extends State<TraineesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UserDataCubit>().fetchAllUsers();
    context.read<UserDataCubit>().fetchUsersByRole(role: widget.role);
    ();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Center(
              child: Image.asset(
                ImageManager.hola,
                width: 98.w,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              width: 439.w,
              height: 94.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF09C1F),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 16.h,
                      ),
                      child: GeneralTextFormField(
                        height: 37.h,
                        controller: _searchController,
                        hintStyle: TextStyle(
                          color: ColorManager.grayColorHeadline,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        hint: "Ex. Name, Mobile",
                        fillColor: ColorManager.whiteColor,
                        prefixIcon: Icon(
                          Icons.search,
                          size: 24.sp,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: -4),
                        borderRadius: 8.r,
                      ),
                    ),
                  ),
                  SizedBox(width: 19.w),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<UserDataCubit>()
                          .searchUsers(_searchController.text, widget.role);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5BD69),
                      minimumSize: Size(128.w, 42.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: ColorManager.whiteColor,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Search',
                          style: TextStyle(
                            color: ColorManager.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            BlocBuilder<UserDataCubit, UserDataState>(
              builder: (context, state) {
                List<User> users;
                if (state is FetchUsersByRoleSuccess) {
                  users = state.users.data.users;
                  if (users.isEmpty) {
                    return Center(
                        child: NotFoundScreen(
                      title: widget.role == AppString.trainee
                          ? 'No Trainees Found'
                          : 'No COACH Found',
                    ));
                  }
                  return Expanded(
                    child: CustomListView(
                      data: users,
                    ),
                  );
                } else if (state is FilterUsersSuccess) {
                  users = state.filteredUsers;
                  return Expanded(
                    child: CustomListView(
                      data: users,
                    ),
                  );
                } else if (state is FetchUsersByRoleFailure) {
                  return NotFoundScreen(
                    title: widget.role == AppString.trainee
                        ? 'No Trainees Found'
                        : 'No COACH Found',
                  );
                } else if (state is UserDataLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: ColorManager.textRedColor,
                  ));
                }
                return Expanded(
                  child: CustomListView(
                    data: widget.role == AppString.trainee
                        ? context.read<UserDataCubit>().trainees
                        : context.read<UserDataCubit>().coaches,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
