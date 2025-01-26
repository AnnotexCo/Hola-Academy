import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hola_academy/core/components/admin_clip_oval.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

class AdminTransactionCard extends StatelessWidget {
  final String title;
  final String dateTime;
  final String price;
  final String status;
  final bool income;

  AdminTransactionCard({
    super.key,
    required this.title,
    required this.dateTime,
    required this.price,
    required this.status,
    required this.income,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: SizedBox(
        //height: 55.h,
        width: 363.w,

        child: ListTile(
          leading: SizedBox(
            height: 56.h,
            width: 56.w,
            child: AdminClipOval(
              color: income
                  ? ColorManager.linearGradient1
                  : ColorManager.softPinkColor,
              image: ImageManager.pic,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: ColorManager.darkGreyForFontColor,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
          subtitle: Text(
            '\$$price',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: income
                  ? ColorManager.primaryOrangeColor
                  : ColorManager.errorRedColor,
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColors[status]?.withValues(alpha: 0.2),
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
              SizedBox(height: 16.h),
              Text(
                dateTime,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
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
