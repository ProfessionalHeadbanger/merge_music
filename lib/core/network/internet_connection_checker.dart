import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class InternetConnectionChecker {
  Future<bool> get isConnected;
}

class InternetConnectionCheckerImpl implements InternetConnectionChecker {
  final InternetConnection _internetConnection;
  InternetConnectionCheckerImpl(this._internetConnection);

  @override
  Future<bool> get isConnected async =>
      await _internetConnection.hasInternetAccess;
}
