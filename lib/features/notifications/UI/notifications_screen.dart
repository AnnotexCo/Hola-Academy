import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hola_academy/core/components/custom_app_bar.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/features/not_found/not_found_screen.dart';
import 'package:hola_academy/features/notifications/UI/widgets/notification_item.dart';
import 'package:hola_academy/features/notifications/Logic/notifications_cubit.dart';
import 'package:intl/intl.dart';

import '../Logic/notifications_state.dart';
import 'loading/shimmer_notifications_list.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<int> selectedNotifications = [];

  @override
  void initState() {
    super.initState();
    context.read<NotificationsCubit>().fetchNotifications();
  }

  void _handlePopupSelection(String value) {
    final cubit = context.read<NotificationsCubit>();

    switch (value) {
      case 'mark_read':
        for (var id in selectedNotifications) {
          cubit.markNotificationAsRead(id);
        }
        setState(() => selectedNotifications.clear());
        break;
      case 'delete':
        for (var id in selectedNotifications) {
          cubit.deleteNotification(id);
        }
        setState(() => selectedNotifications.clear());
        break;
      case 'select_all':
        final state = context.read<NotificationsCubit>().state;
        if (state is NotificationsLoaded) {
          setState(() {
            selectedNotifications = state.notifications
                .map((notification) => notification.id)
                .toList();
          });
        }
        break;
    }
  }

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
                PopupMenuItem(value: 'mark_read', child: Text('Mark as read')),
                PopupMenuItem(value: 'delete', child: Text('Delete')),
                PopupMenuItem(value: 'select_all', child: Text('Select All')),
              ],
              onSelected: _handlePopupSelection,
            ),
          ),
          Expanded(
            child: BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                if (state is NotificationsLoading) {
                  return ShimmerNotificationsList();
                } else if (state is NotificationsError) {
                  return NotFoundScreen(title: state.message);
                } else if (state is NotificationsLoaded) {
                  final notifications = state.notifications;
                  if (notifications.isEmpty) {
                    return Center(child: Text("No notifications available"));
                  }

                  return ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];

                      // Check if this is the first notification of a new date
                      bool showHeader = index == 0 ||
                          notification.createdAt.split(',')[0] !=
                              notifications[index - 1].createdAt.split(',')[0];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (showHeader)
                            _buildDateHeader(
                                notification.createdAt), // Add date header
                          Slidable(
                            endActionPane: ActionPane(
                              motion: const StretchMotion(),
                              extentRatio: 0.25,
                              children: [
                                CustomSlidableAction(
                                  onPressed: (_) {
                                    context
                                        .read<NotificationsCubit>()
                                        .deleteNotification(notification.id);
                                  },
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    padding: EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withValues(alpha: 0.3),
                                          blurRadius: 4,
                                          spreadRadius: 2,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Icon(Icons.delete,
                                        color: Color(0xffBB4227), size: 20),
                                  ),
                                ),
                              ],
                            ),
                            child: NotificationItem(
                              id: notification.id,
                              title: notification.title,
                              message: notification.message,
                              time: DateFormat('h:mm a').format(DateTime.parse(notification.createdAt)),
                              icon: Icons.notifications_active_sharp,
                              iconColor: Colors.amber,
                              isSelected: selectedNotifications
                                  .contains(notification.id),
                              onSelected: (isSelected) {
                                setState(() {
                                  if (isSelected) {
                                    selectedNotifications.add(notification.id);
                                  } else {
                                    selectedNotifications
                                        .remove(notification.id);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                return NotFoundScreen(title: "No notifications available");
              },
            ),
          ),
        ],
      ),
    );
  }


Widget _buildDateHeader(String dateString) {
  DateTime date = DateTime.parse(dateString);
  DateTime now = DateTime.now();
  DateTime yesterday = now.subtract(Duration(days: 1));

  String formattedDate;
  if (DateFormat('yyyy-MM-dd').format(date) == DateFormat('yyyy-MM-dd').format(now)) {
    formattedDate = 'Today, ${DateFormat('MMM d').format(date)}';
  } else if (DateFormat('yyyy-MM-dd').format(date) == DateFormat('yyyy-MM-dd').format(yesterday)) {
    formattedDate = 'Yesterday, ${DateFormat('MMM d').format(date)}';
  } else {
    formattedDate = DateFormat('MMM d').format(date);
  }

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 45.w),
    child: Text(
      formattedDate,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    ),
  );
}

}
