import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

class TransactionCard extends StatelessWidget {
  final String title;
  final String dateTime;
  final String price;
  final String status;

  TransactionCard({
    super.key,
    required this.title,
    required this.dateTime,
    required this.price,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Container(
        //height: 55.h,
        width: 363.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: ColorManager.shadowColor,
              blurStyle: BlurStyle.inner,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(2, 2),
            )
          ],
        ),
        child: ListTile(
          leading: SvgPicture.asset(
            ImageManager.confirm,
            height: 24.h,
            width: 24.w,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: ColorManager.graycolorHeadline,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
          subtitle: Text(
            dateTime,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '\$$price',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: ColorManager.graycolorHeadline,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColors[status]?.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 8.sp,
                    color: statusColors[status] ??
                        Colors.grey, // Default color if status is not found,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Map for statuses and their colors
  final Map<String, Color> statusColors = {
    'Pending': Colors.orange,
    'Confirmed': Colors.green,
    'Canceled': Colors.red,
  };
}
