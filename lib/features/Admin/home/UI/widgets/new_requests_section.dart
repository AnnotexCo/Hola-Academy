import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/admin_clip_oval.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/constants/color_manager.dart';
import '../../../requests/Data/Model/requests_model.dart';
import '../../../requests/Logic/requests_cubit.dart';
import '../../../requests/Logic/requests_state.dart';
import '../loading/new_requests_shimmer.dart';

class NewRequestsSection extends StatelessWidget {
  const NewRequestsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestsCubit, RequestsState>(
      builder: (context, state) {
        if (state is RequestsLoading) {
          return const NewRequestsShimmer();
        } else if (state is RequestsError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is AllRequestsSuccess) {
          final List<RequestsModel> requests =
              state.requestsList.take(3).toList(); // Limit to max 3 requests

          if (requests.isEmpty) {
            return const Center(child: Text('No new requests.'));
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: requests.length, // Dynamic count (1, 2, or 3)
            separatorBuilder: (_, __) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final request = requests[index];

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left Dot
                  Container(
                    width: 12.w,
                    height: 12.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorManager.primaryOrangeColor,
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Profile Image with AdminClipOval
                  AdminClipOval(
                    color: ColorManager.linearGradient1,
                    image: request.user?.profileImage?.path != null
                        ? "${ApiConstants.imagesURLApi}${request.user?.profileImage?.path}"
                        : "assets/images/profilepic.png", // Default Image
                  ),

                  SizedBox(width: 12.w),

                  // Name and Type
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.user?.name ?? 'Unknown',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          request.user?.role ?? 'Unknown',
                          style: TextStyle(
                              fontSize: 10.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),

                  // Status and Date
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: _getStatusColor(request.status)
                              .withValues(alpha:0.1),
                          borderRadius: BorderRadius.all(Radius.circular(12.r)),
                        ),
                        child: Text(
                          request.status.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: _getStatusColor(request.status),
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        request.createdAt.toString(),
                        style: TextStyle(
                            fontSize: 10.sp, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        } else {
          return const Center(child: Text('No Data'));
        }
      },
    );
  }

  // Status Color Helper Function
  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
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