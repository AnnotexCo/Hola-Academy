import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/color_manager.dart';

// ignore: must_be_immutable
class NotificationItem extends StatefulWidget {
  final String title;
  final String message;

  final String time;
  final IconData icon;
  final Color iconColor;
  bool? isSelected;

  NotificationItem({
    super.key,
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.iconColor,
    this.isSelected = false,
  });

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 9.w,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 18.h,
          width: 18.w,
          child: Checkbox(
            activeColor: ColorManager.primaryOrangeColor,
            checkColor: Colors.white,
            value: widget.isSelected,
            onChanged: (value) {
              setState(() {
                widget.isSelected = !widget.isSelected!;
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ),
        Container(
          width: 370.w,
          margin: EdgeInsets.only(bottom: 12.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                margin: EdgeInsets.only(top: 8.h),
                child: Icon(widget.icon, color: widget.iconColor, size: 30.r),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Column(
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        widget.message,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black54,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            widget.time,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
