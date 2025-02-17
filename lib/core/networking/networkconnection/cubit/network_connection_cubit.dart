import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'network_connection_state.dart';

class NetworkConnectionCubit extends Cubit<NetworkConnectionState> {
  final InternetConnectionChecker _connectionChecker;
  StreamSubscription<InternetConnectionStatus>? _subscription;
  bool isConnected = false;

  NetworkConnectionCubit()
      : _connectionChecker = InternetConnectionChecker.createInstance(),
        super(NetworkInitial()) {
    _monitorNetwork();
  }

  void _monitorNetwork() async {
    bool initialStatus = await _connectionChecker.hasConnection;
    isConnected = initialStatus;
    emit(isConnected ? NetworkConnected() : NetworkDisconnected());

    _subscription = _connectionChecker.onStatusChange.listen(
      (status) {

        final newState = (status == InternetConnectionStatus.connected);
        if (newState != isConnected) {
          isConnected = newState;
          emit(isConnected ? NetworkConnected() : NetworkDisconnected());
        }
      },
      onError: (error) {
          print("Network error: $error");

      },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
