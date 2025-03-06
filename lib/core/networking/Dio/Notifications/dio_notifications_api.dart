import 'package:dio/dio.dart';
import '../../../../features/notifications/Data/Model/notification_model.dart';
import '../../../constants/api_constants.dart';
import '../../ErrorHandler/api_error_handler.dart';

class DioNotificationsApi {
  final Dio _dio;

  DioNotificationsApi({required Dio dio}) : _dio = dio;

  /// **Fetch All Notifications**
  Future<List<NotificationData>> fetchNotifications() async {
    try {
      final response = await _dio.get('${ApiConstants.baseUrl}${ApiConstants.notificationsApi}',
     
      );

      if (response.statusCode == 200) {
        final NotificationModel notificationModel = NotificationModel.fromMap(response.data);
        return notificationModel.data;
      } else {
        throw Exception("Failed to load notifications");
      }
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }

  /// **Fetch Notification by ID**
  Future<NotificationData> fetchNotificationById(int id) async {
    try {
      final response = await _dio.get('${ApiConstants.baseUrl}${ApiConstants.notificationsByIdApi}$id');

      if (response.statusCode == 200) {
        return NotificationData.fromMap(response.data);
      } else {
        throw Exception("Failed to fetch notification");
      }
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }

  /// **Fetch Notifications by Read Status (READ or UNREAD)**
  Future<List<NotificationData>> fetchNotificationsByStatus(String status) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.notificationUdateStatusApi}$status',
      );

      if (response.statusCode == 200) {
        final NotificationModel notificationModel = NotificationModel.fromMap(response.data);
        return notificationModel.data;
      } else {
        throw Exception("Failed to load filtered notifications");
      }
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }

  /// **Mark Notification as Read**
  Future<void> markNotificationAsRead(int notificationId) async {
    try {
      final response = await _dio.patch(
        '${ApiConstants.baseUrl}${ApiConstants.notificationUdateStatusApi}READ',
        data: {"id": notificationId},
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to mark notification as read");
      }
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }

  /// **Delete Notification**
  Future<void> deleteNotification(int notificationId) async {
    try {
      final response = await _dio.delete('${ApiConstants.baseUrl}${ApiConstants.notificationsByIdApi}$notificationId');

      if (response.statusCode != 200) {
        throw Exception("Failed to delete notification");
      }
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }
}
