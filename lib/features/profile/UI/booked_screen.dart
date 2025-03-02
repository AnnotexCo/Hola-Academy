import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hola_academy/core/components/custom_app_bar.dart';
import 'package:hola_academy/core/constants/api_constants.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/features/not_found/not_found_screen.dart';
import 'package:hola_academy/features/profile/UI/loading/booked-shimmer.dart';

import '../../Admin/requests/Logic/requests_cubit.dart';
import '../../Admin/requests/Logic/requests_state.dart';
import 'widgets/booked_cared.dart';

class BookedScreen extends StatelessWidget {
  const BookedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: AppString.booked, isBack: true),
          Expanded(
            child: BlocBuilder<RequestsCubit, RequestsState>(
              builder: (context, state) {
                if (state is RequestsLoading) {
                  return bookedShimmerEffect();
                } else if (state is RequestsError) {
                  return NotFoundScreen(title:state.message);
                } else if (state is AllRequestsSuccess) {
                  final requests = state.requestsList;

                  if (requests.isEmpty) {
                    return NotFoundScreen(title:'No bookings found.');
                  }

                  return ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    itemCount: requests.length,
                    itemBuilder: (context, index) {
                      final request = requests[index];

                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: BookedCard(
                          imageUrl:
                              '${ApiConstants.imagesURLApi}${request.file?.path}',
                          title: request.program?.name ?? "Unknown Program",
                          minAge: request.program?.minAge.toString() ?? "N/A",
                          maxAge: request.program?.maxAge.toString() ?? "N/A",
                          suitableFor: request.program?.allowedGender ?? "All",
                          status: request.status,
                        ),
                      );
                    },
                  );
                } else {
                  return NotFoundScreen(title: 'No data available.');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
