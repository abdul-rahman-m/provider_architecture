import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionManager {
  ConnectivityResult? _connectivityResult;
  void Function(bool hasConnection)? _onInternetConnectionChanged;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  // Private constructor for singleton pattern
  ConnectionManager._internal() {
    // Listen to connectivity changes
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_onConnectionStatusChanges);
  }

  // Singleton instance
  static ConnectionManager shared = ConnectionManager._internal();

  // Handles connectivity changes
  void _onConnectionStatusChanges(ConnectivityResult result) {
    _connectivityResult = result;
    if (_onInternetConnectionChanged != null) {
      _onInternetConnectionChanged!(hasInternetConnection);
    }
  }

  // Checks if the internet connection is available
  Future<bool> internetConnectionAvailable() async {
    final result = await _connectivity.checkConnectivity();
    _connectivityResult = result;
    return hasInternetConnection;
  }

  // Checks if there is an active internet connection
  bool get hasInternetConnection {
    return _connectivityResult == ConnectivityResult.mobile ||
        _connectivityResult == ConnectivityResult.wifi;
  }

  // Sets a listener for internet connection changes
  void setListener(void Function(bool hasConnection) listener) {
    _onInternetConnectionChanged = listener;
  }

  // Disposes the connectivity subscription
  void dispose() {
    _connectivitySubscription.cancel();
  }
}
