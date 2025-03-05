import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

class TransactionCard extends StatefulWidget {
  final String title;
  final String dateTime;
  final String price;
  final String status;
  final String userCase;

  const TransactionCard({
    super.key,
    required this.title,
    required this.dateTime,
    required this.price,
    required this.status,
    required this.userCase,
  });

  @override
  _TransactionCardState createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Stack(
        children: [
          if (_isHovered && widget.status == "CANCELLED")
            Padding(
              padding: EdgeInsets.only(top: 60.h),
              child: Container(
                width: 363.w,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorManager.textRedColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.r),
                      bottomRight: Radius.circular(12.r)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 15.h),
                  child: Text(
                    AppString.canceledNote,
                    style: TextStyle(
                      fontSize: 8.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isHovered = !_isHovered;
              });
            },
            child: Container(
              width: 363.w,
              height: 75.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  _isHovered && widget.status == "CANCELLED"
                      ? BoxShadow()
                      : BoxShadow(
                          color: ColorManager.shadowColor,
                          blurStyle: BlurStyle.inner,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        ),
                ],
              ),
              child: ListTile(
                leading: SvgPicture.asset(
                  widget.userCase == "INCOME"?
                  ImageManager.confirm: ImageManager.expenses,
                  height: 24.h,
                  width: 24.w,
                ),
                title: Text(
                  widget.title,
                  style: TextStyle(
                    color: ColorManager.graycolorHeadline,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                subtitle: Text(
                  widget.dateTime,
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
                      '\$${widget.price}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: ColorManager.graycolorHeadline,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColors[widget.status]?.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.status,
                        style: TextStyle(
                          fontSize: 8.sp,
                          color: statusColors[widget.status] ?? Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Map for statuses and their colors
  final Map<String, Color> statusColors = {
    'PENDING': Colors.orange,
    'COMPLETED': Colors.green,
    'CANCELED': Colors.red,
  };
}
