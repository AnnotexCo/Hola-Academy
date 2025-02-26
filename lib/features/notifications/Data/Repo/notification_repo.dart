import 'package:hola_academy/core/networking/Dio/Notifications/dio_notifications_api.dart';
import '../Model/notification_model.dart';

class NotificationsRepo {
  final DioNotificationsApi dioNotificationsApi;

  NotificationsRepo({required this.dioNotificationsApi});

  /// Fetch all notifications
  Future<List<NotificationData>> fetchNotifications() async {
    return await dioNotificationsApi.fetchNotifications();
  }

  /// Fetch notification by ID
  Future<NotificationData> fetchNotificationById(int id) async {
    return await dioNotificationsApi.fetchNotificationById(id);
  }

  /// Fetch notifications by status (READ or UNREAD)
  Future<List<NotificationData>> fetchNotificationsByStatus(String status) async {
    return await dioNotificationsApi.fetchNotificationsByStatus(status);
  }

  /// Mark notification as READ
  Future<void> markNotificationAsRead(int notificationId) async {
    await dioNotificationsApi.markNotificationAsRead(notificationId);
  }

  /// Delete a notification
  Future<void> deleteNotification(int notificationId) async {
    await dioNotificationsApi.deleteNotification(notificationId);
  }
}
