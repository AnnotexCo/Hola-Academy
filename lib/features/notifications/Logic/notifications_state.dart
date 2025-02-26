import 'package:equatable/equatable.dart';
import '../../../../features/notifications/Data/Model/notification_model.dart';

abstract class NotificationsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationData> notifications;
  NotificationsLoaded({required this.notifications});

  @override
  List<Object?> get props => [notifications];
}

class NotificationsError extends NotificationsState {
  final String message;
  NotificationsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class NotificationUpdated extends NotificationsState {}

class NotificationDeleted extends NotificationsState {}
