part of 'network_connection_cubit.dart';

sealed class NetworkConnectionState extends Equatable {
  const NetworkConnectionState();

  @override
  List<Object> get props => [];
}

final class NetworkInitial extends NetworkConnectionState {}

class NetworkConnected extends NetworkConnectionState {}

class NetworkDisconnected extends NetworkConnectionState {}
