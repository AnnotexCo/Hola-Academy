import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/features/not_found/not_found_screen.dart';
import 'package:hola_academy/features/profile/Data/Model/user_model.dart';
import 'package:hola_academy/features/profile/Logic/personal_info/user_data_cubit.dart';

import '../../../../core/components/custom_app_bar.dart';
import '../../../../core/components/custom_dialog.dart';
import '../../../../core/components/general_text_form_field.dart';
import '../../../../core/components/options_buttons.dart';
import '../../../../core/constants/color_manager.dart';
import '../Data/Model/requests_model.dart';
import '../Logic/requests_cubit.dart';
import '../Logic/requests_state.dart';
import '../loading/requests_loading_shimmer.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  String activeOption = 'PENDING';
  UserModel? loggedInUser;
  @override
  void initState() {
    super.initState();
    context.read<RequestsCubit>().fetchAllRequests();
    context.read<UserDataCubit>().getMyData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: 'Requests'),
          const SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                OptionSelector(
                  options: ['PENDING', 'ACCEPTED', 'REJECTED'],
                  activeOption: activeOption,
                  onOptionSelected: (selectedOption) {
                    setState(() {
                      activeOption = selectedOption;
                    });
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<UserDataCubit, UserDataState>(
              builder: (context, userState) {
                if (userState is UserDataSuccess) {
                  loggedInUser = userState.userModel;
                }

                return BlocBuilder<RequestsCubit, RequestsState>(
                  builder: (context, state) {
                    if (state is RequestsLoading) {
                      return buildRequestsLoadingShimmer();
                    } else if (state is RequestsError) {
                      return  NotFoundScreen(title:'Error: ${state.message}');
                    } else if (state is AllRequestsSuccess) {
                      final filteredRequests = state.requestsList
                          .where((request) => request.status.toUpperCase() == activeOption)
                          .toList();

                      if (filteredRequests.isEmpty) {
                        return NotFoundScreen(title: 'No requests available.');
                      }

                      return ListView.builder(
                        itemCount: filteredRequests.length,
                        itemBuilder: (context, index) {
                          return buildRequestItem(context, filteredRequests[index]);
                        },
                      );
                    } else {
                      return NotFoundScreen(title: ('No Data'));
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showRequestDetailsDialog(BuildContext context, RequestsModel? request) {
    //  final bool isUserRequest = (loggedInUser?.id == request?.userId);
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title:  loggedInUser?.name ?? 'Unknown User' ,
          imageUrl: 'assets/images/profilepic.png', //TODO: check it in model ????? loggedInUser?.profileImageId.toString() ?? 
          onCancel: () {
            Navigator.of(context).pop();
          },
          components: [
            GeneralTextFormField(
              fillColor: ColorManager.whiteColor,
              hint: request?.note ?? 'note not available',
              hintStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: ColorManager.textRedColor,
              ),
              readOnly: true,
            ),
            SizedBox(height: 10.h),
            GeneralTextFormField(
              fillColor: ColorManager.whiteColor,
              hintStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: ColorManager.textRedColor,
              ),
              hint: loggedInUser?.phoneNumber ?? 'phone not available',
              readOnly: true,
            ),
            SizedBox(height: 10.h),
            GeneralTextFormField(
              fillColor: ColorManager.whiteColor,
              hintStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: ColorManager.textRedColor,
              ),
              hint: request?.programId.toString()?? 'program not available', // TODO: check it in backend
              readOnly: true,
            ),
            SizedBox(height: 10.h),
            GeneralTextFormField(
              fillColor: ColorManager.whiteColor,
              hintStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: ColorManager.textRedColor,
              ),
              hint: loggedInUser?.userType ?? 'type not available',
              readOnly: true,
            ),
            SizedBox(height: 10.h),
            GeneralTextFormField(
              fillColor: ColorManager.whiteColor,
              hintStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: ColorManager.textRedColor,
              ),
              hint: loggedInUser?.gender ?? 'gender not available',
              readOnly: true,
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primaryOrangeColor,
                      fixedSize: Size(119.w, 30.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(32.r),
                        ),
                      ),
                    ),
                    child: Text(
                      'Accept',
                      style: TextStyle(
                        color: ColorManager.whiteColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                        color: ColorManager.primaryOrangeColor,
                      ),
                      backgroundColor: ColorManager.whiteColor,
                      fixedSize: Size(119.w, 30.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(32.r),
                        ),
                      ),
                    ),
                    child: Text(
                      'Reject',
                      style: TextStyle(
                        color: ColorManager.primaryOrangeColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildRequestItem(BuildContext context, RequestsModel? request) {
    return GestureDetector(
      onTap: () {
        _showRequestDetailsDialog(context, request);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Pentagon-shaped Container with Image
            Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: Size(56.w, 56.h),
                  painter: PentagonPainter(
                    const Color(0xFFFEF5E9),
                  ),
                ),
                ClipOval(
                  child: SizedBox(
                    width: 36.w,
                    height: 36.h,
                    child: CachedNetworkImage(
                      imageUrl: loggedInUser?.profileImage.toString() ?? 'assets/images/default_profile.png',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error, size: 36.w, color: ColorManager.redMagmaColor,),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            // Name and Type
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loggedInUser?.name ?? '',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    loggedInUser?.userType ?? '',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            // Status and Date
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: _getStatusColor(
                      request?.status.toUpperCase() ?? '',
                    ).withValues(alpha: 0.1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    request?.status.toUpperCase() ?? '',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: _getStatusColor(
                        request?.status.toUpperCase()?? '',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  request?.createdAt.toString() ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'PENDING':
        return const Color(0xFFFFB74D);
      case 'ACCEPTED':
        return const Color(0xFF4CAF50);
      case 'REJECTED':
        return const Color(0xFFE53935);
      default:
        return const Color(0xFFFFB74D);
    }
  }
}

// Custom Painter for Pentagon Shape
class PentagonPainter extends CustomPainter {
  final Color color;

  PentagonPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path();
    final width = size.width;
    final height = size.height;

    path.moveTo(width * 0.5, 0); // Top point
    path.lineTo(width, height * 0.38); // Top-right
    path.lineTo(width * 0.81, height); // Bottom-right
    path.lineTo(width * 0.19, height); // Bottom-left
    path.lineTo(0, height * 0.38); // Top-left
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
