import 'package:bloc/bloc.dart';

import '../Data/Repo/notification_repo.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepo notificationsRepo;

  NotificationsCubit(this.notificationsRepo) : super(NotificationsInitial());

  /// Fetch all notifications
  Future<void> fetchNotifications() async {
    if (!isClosed) emit(NotificationsLoading());
    try {
      final notifications = await notificationsRepo.fetchNotifications();
      if (!isClosed) emit(NotificationsLoaded(notifications: notifications));
    } catch (e) {
      if (!isClosed) emit(NotificationsError(message: e.toString()));
    }
  }

  /// Fetch notification by ID
  Future<void> fetchNotificationById(int id) async {
    if (!isClosed) emit(NotificationsLoading());
    try {
      final notification = await notificationsRepo.fetchNotificationById(id);
      if (!isClosed) emit(NotificationsLoaded(notifications: [notification]));
    } catch (e) {
      if (!isClosed) emit(NotificationsError(message: e.toString()));
    }
  }

  /// Fetch notifications by status
  Future<void> fetchNotificationsByStatus(String status) async {
    if (!isClosed) emit(NotificationsLoading());
    try {
      final notifications =
          await notificationsRepo.fetchNotificationsByStatus(status);
      if (!isClosed) emit(NotificationsLoaded(notifications: notifications));
    } catch (e) {
      if (!isClosed) emit(NotificationsError(message: e.toString()));
    }
  }

  /// Mark notification as READ
  Future<void> markNotificationAsRead(int id) async {
    try {
      await notificationsRepo.markNotificationAsRead(id);
      if (!isClosed) emit(NotificationUpdated());
    } catch (e) {
      if (!isClosed) emit(NotificationsError(message: e.toString()));
    }
  }

  /// Delete notification
  Future<void> deleteNotification(int id) async {
    try {
      await notificationsRepo.deleteNotification(id);
      if (!isClosed) emit(NotificationDeleted());
    } catch (e) {
      if (!isClosed) emit(NotificationsError(message: e.toString()));
    }
  }
}
