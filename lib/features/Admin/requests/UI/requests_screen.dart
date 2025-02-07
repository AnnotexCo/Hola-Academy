import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/custom_app_bar.dart';
import '../../../../core/components/custom_dialog.dart';
import '../../../../core/components/general_text_form_field.dart';
import '../../../../core/components/options_buttons.dart';
import '../../../../core/constants/color_manager.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  String activeOption = 'Accepted';

  final List<Map<String, String>> allRequests = [
    {
      'name': 'John Doe',
      'type': 'private',
      'program': 'Educationl',
      'status': 'Accepted',
      'phone': '1234567890',
      'gender': 'Male',
      'image': 'assets/images/profilepic.png'
    },
    {
      'name': 'Jane Smith',
      'type': 'General',
      'status': 'Pending',
      'program': 'Educationl',
      'phone': '1234567890',
      'gender': 'Male',
      'image': 'assets/images/profilepic.png'
    },
    {
      'name': 'Robert Brown',
      'type': 'Private',
      'status': 'Rejected',
      'program': 'Educationl',
      'phone': '1234567890',
      'gender': 'Male',
      'image': 'assets/images/profilepic.png'
    },
    {
      'name': 'Alice Johnson',
      'type': 'General',
      'status': 'Accepted',
      'program': 'Educationl',
      'phone': '0154442284',
      'gender': 'Male',
      'image': 'assets/images/profilepic.png'
    },
  ];

  List<Map<String, String>> get filteredRequests {
    return allRequests
        .where((request) => request['status'] == activeOption)
        .toList();
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
                  options: ['Pending', 'Accepted', 'Rejected'],
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
            child: ListView.builder(
              itemCount: filteredRequests.length,
              itemBuilder: (context, index) {
                final request = filteredRequests[index];
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialog(
                          title: request['name'] ?? 'Unknown',
                          imageUrl: request['image'] ??
                              'assets/images/default_profile.png',
                          onCancel: () {
                            Navigator.of(context).pop();
                          },
                          components: [
                            GeneralTextFormField(
                              fillColor: ColorManager.whiteColor,
                              hint: request['name'] ?? 'Name not available',
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
                              hint: request['phone'] ?? 'phone not available',
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
                              hint: request['program'] ?? 'program not available',
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
                              hint: request['type'] ?? 'type not available',
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
                              hint: request['gender'] ?? 'gender not available',
                              readOnly: true,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          ColorManager.primaryOrangeColor,
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
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
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
                                child: Image.asset(
                                  request['image'] ?? '',
                                  fit: BoxFit.cover,
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
                                request['name'] ?? '',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                request['type'] ?? '',
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: _getStatusColor(
                                  request['status'] ?? '',
                                ).withValues(alpha: 0.1),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                request['status'] ?? '',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  color: _getStatusColor(
                                    request['status'] ?? '',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              request['date'] ?? '',
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
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return const Color(0xFFFFB74D);
      case 'Accepted':
        return const Color(0xFF4CAF50);
      case 'Rejected':
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
