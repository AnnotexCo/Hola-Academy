import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/color_manager.dart';

import '../../../core/Routing/routes.dart';

class EvaluationAppointmentCard extends StatelessWidget {
  final VoidCallback? onScheduleCheck;
  final String location;
  final List<String> requiredItems;

  const EvaluationAppointmentCard({
    super.key,
    this.onScheduleCheck,
    this.location = "Naser City, Training Area A",
    this.requiredItems = const [
      "Swimwear: Bring Proper Swimwear",
      "Accessories: Don't Forget A Swim Cap And Goggles For Your Session",
      "Other: Carry A Towel And Water Bottle For Hydration",
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ColorManager.redMagmaColor,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding:
            EdgeInsets.only(left: 20.w, right: 10.w, top: 10.h, bottom: 8.h),
        child: Column(
          spacing: 16.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Evaluation Appointment',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Colors.redAccent,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildScheduleButton(context),
                      SizedBox(height: 12.h),
                      _buildLocationInfo(),
                      SizedBox(height: 12.h),
                      _buildEarlyArrivalNote(),
                    ],
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Image.asset(
                    height: 110.h,
                    width: 137.w,
                    'assets/images/evaluationimg.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            _buildRequiredItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleButton(context) {
    return Row(
      children: [
        Icon(
          Icons.help_outline,
          color: Colors.redAccent,
          size: 20.r,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.scheduleEvaluationScreen);
            },
            //  onScheduleCheck,
            child: RichText(
              text: TextSpan(
                text: 'To Check Your Available Schedule, ',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(
                    text: 'Click Here',
                    style: TextStyle(
                      color: Colors.redAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationInfo() {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          color: Colors.redAccent,
          size: 20.r,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            location,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 11.sp,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEarlyArrivalNote() {
    return Row(
      children: [
        Icon(
          Icons.warning_amber_outlined,
          color: Colors.redAccent,
          size: 20.r,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            'Please Arrive 30 Minutes Early For Your Evaluation',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 11.sp,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRequiredItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.circle,
              color: Colors.redAccent,
              size: 20.r,
            ),
            SizedBox(width: 8.w),
            Text(
              'Required Items:',
              style: TextStyle(
                fontSize: 14.sp,
                color: ColorManager.redMagmaColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        ...requiredItems.map((item) => Padding(
              padding: EdgeInsets.only(left: 28.w),
              child: Text(
                item,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 11.sp,
                  color: ColorManager.redMagmaColor,
                ),
              ),
            )),
      ],
    );
  }
}
