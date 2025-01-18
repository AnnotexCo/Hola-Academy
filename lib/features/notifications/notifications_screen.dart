import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/components/custom_app_bar.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/features/notifications/widgets/notification_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: Column(
        children: [
          CustomAppBar(
            title: "Notification",
            widget: PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: Colors.black87),
              borderRadius: BorderRadius.circular(12.r),
              color: ColorManager.backgroundColor,
              offset: Offset(-15, 40.h),
              itemBuilder: (context) => [
                PopupMenuItem(
                  height: 15.h,
                  value: 'mark_read',
                  child: Text('Mark as read'),
                ),
                PopupMenuItem(
                  height: 15.h,
                  value: 'delete',
                  child: Text('Delete'),
                ),
                PopupMenuItem(
                  height: 15.h,
                  value: 'select_all',
                  child: Text('Select All'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              children: [
                _buildDateHeader('Today, Jan 7'),
                NotificationItem(
                  title: 'Evaluation Appointment Scheduled',
                  message:
                      'Your Evaluation Appointment Has Been Scheduled For Jan 10. Please Be On Time.',
                  time: '8:25 AM',
                  icon: Icons.notifications_active_sharp,
                  iconColor: Colors.amber,
                  isSelected: true,
                ),
                NotificationItem(
                  title: 'Registration Request Received',
                  message:
                      'Your Registration Request Has Been Received And Is Being Processed By The Admin. You Will Be Updated Shortly.',
                  time: '5:15 PM',
                  icon: Icons.warning_rounded,
                  iconColor: Colors.orange,
                  isSelected: true,
                ),
                _buildDateHeader('Yesterday, Jan 6'),
                NotificationItem(
                  title: 'Payment Successful',
                  message:
                      'Your Payment Has Been Successfully Processed. Your Booking Is Now Confirmed',
                  time: '3:00 PM',
                  icon: Icons.check_circle,
                  iconColor: Colors.orange,
                  isSelected: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateHeader(String date) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 45.w),
      child: Text(
        date,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}
