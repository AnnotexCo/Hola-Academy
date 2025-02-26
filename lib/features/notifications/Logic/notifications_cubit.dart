import 'package:bloc/bloc.dart';

import '../Data/Repo/notification_repo.dart';
import 'notifications_state.dart';



class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepo notificationsRepo;

  NotificationsCubit(this.notificationsRepo) : super(NotificationsInitial());

  /// Fetch all notifications
  Future<void> fetchNotifications() async {
    emit(NotificationsLoading());
    try {
      final notifications = await notificationsRepo.fetchNotifications();
      emit(NotificationsLoaded(notifications: notifications));
    } catch (e) {
      emit(NotificationsError(message: e.toString()));
    }
  }

  /// Fetch notification by ID
  Future<void> fetchNotificationById(int id) async {
    emit(NotificationsLoading());
    try {
      final notification = await notificationsRepo.fetchNotificationById(id);
      emit(NotificationsLoaded(notifications: [notification]));
    } catch (e) {
      emit(NotificationsError(message: e.toString()));
    }
  }

  /// Fetch notifications by status
  Future<void> fetchNotificationsByStatus(String status) async {
    emit(NotificationsLoading());
    try {
      final notifications = await notificationsRepo.fetchNotificationsByStatus(status);
      emit(NotificationsLoaded(notifications: notifications));
    } catch (e) {
      emit(NotificationsError(message: e.toString()));
    }
  }

  /// Mark notification as READ
  Future<void> markNotificationAsRead(int id) async {
    try {
      await notificationsRepo.markNotificationAsRead(id);
      emit(NotificationUpdated());
    } catch (e) {
      emit(NotificationsError(message: e.toString()));
    }
  }

  /// Delete notification
  Future<void> deleteNotification(int id) async {
    try {
      await notificationsRepo.deleteNotification(id);
      emit(NotificationDeleted());
    } catch (e) {
      emit(NotificationsError(message: e.toString()));
    }
  }
}
