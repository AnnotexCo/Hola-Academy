import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/api_constants.dart';
import 'package:hola_academy/features/not_found/not_found_screen.dart';
import '../../../../core/components/custom_app_bar.dart';
import '../../../../core/components/custom_dialog.dart';
import '../../../../core/components/general_text_form_field.dart';
import '../../../../core/components/options_buttons.dart';
import '../../../../core/constants/color_manager.dart';
import '../../home/UI/home_admin_screen.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<RequestsCubit>().fetchAllRequests();
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
            child: BlocBuilder<RequestsCubit, RequestsState>(
              builder: (context, state) {
                if (state is RequestsLoading) {
                  return buildRequestsLoadingShimmer();
                } else if (state is RequestsError) {
                  return NotFoundScreen(title: 'Error: ${state.message}');
                } else if (state is AllRequestsSuccess) {
                  final filteredRequests = state.requestsList
                      .where((request) =>
                          request.status.toUpperCase() == activeOption)
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
            ),
          ),
        ],
      ),
    );
  }

  void _showRequestDetailsDialog(BuildContext context, RequestsModel request) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: request.user?.name ?? 'Unknown user',
          imageUrl:
              "${ApiConstants.imagesURLApi}${request.user?.profileImage?.path}",
          onCancel: () {
            Navigator.of(context).pop();
          },
          components: [
            GeneralTextFormField(
              fillColor: ColorManager.whiteColor,
              hint: request.note,
              hintStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.textRedColor),
              readOnly: true,
            ),
            SizedBox(height: 10.h),
            GeneralTextFormField(
              fillColor: ColorManager.whiteColor,
              hint: request.user?.phoneNumber ?? 'Phone not available',
              hintStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.textRedColor),
              readOnly: true,
            ),
            SizedBox(height: 10.h),
            GeneralTextFormField(
              fillColor: ColorManager.whiteColor,
              hint: request.program?.name ?? 'program not available',
              hintStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.textRedColor),
              readOnly: true,
            ),
            SizedBox(height: 10.h),
            GeneralTextFormField(
              fillColor: ColorManager.whiteColor,
              hint: request.user?.role ?? 'Type not available',
              hintStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.textRedColor),
              readOnly: true,
            ),
            SizedBox(height: 10.h),
            GeneralTextFormField(
              fillColor: ColorManager.whiteColor,
              hint: request.user?.gender ?? 'Gender not available',
              hintStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.textRedColor),
              readOnly: true,
            ),
          ],
        );
      },
    );
  }

  Widget buildRequestItem(BuildContext context, RequestsModel request) {
    return GestureDetector(
      onTap: () {
        _showRequestDetailsDialog(context, request);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                    size: Size(56.w, 56.h),
                    painter: PentagonPainter(Color(0xFFFEF5E9))),
                ClipOval(
                  child: SizedBox(
                    width: 36.w,
                    height: 36.h,
                    child: CachedNetworkImage(
                      imageUrl:
                          "${ApiConstants.imagesURLApi}${request.user?.profileImage?.path}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error,
                          size: 36.w, color: ColorManager.redMagmaColor),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(request.user?.name ?? 'Unknown',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(request.user?.role ?? 'Unknown',
                      style: TextStyle(
                          fontSize: 10.sp, fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: _getStatusColor(request.status.toUpperCase())
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Text(
                    request.status.toUpperCase(),
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: _getStatusColor(request.status.toUpperCase())),
                  ),
                ),
                const SizedBox(height: 4),
                Text(request.createdAt.toString(),
                    style: TextStyle(
                        fontSize: 10.sp, fontWeight: FontWeight.w400)),
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
