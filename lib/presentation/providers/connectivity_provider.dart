import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetConnectionProvider with ChangeNotifier {
  bool _isConnected = true;

  bool get isConnected => _isConnected;

  InternetConnectionProvider() {
    _initConnectivity();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectionStatus(result);
    });
  }

  Future<void> _initConnectivity() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    bool connected = result != ConnectivityResult.none;
    if (_isConnected != connected) {
      _isConnected = connected;
      notifyListeners();
    }
  }

  Future<bool> hasInternetConnection() async {
    return _isConnected;
  }
}
