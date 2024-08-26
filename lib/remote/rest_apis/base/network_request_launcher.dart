

import 'package:provider_stub/providers/primary_provider.dart';
import 'package:provider_stub/utils/connection_manager.dart';

class NetworkRequestLauncher {
  NetworkRequestLauncher._internal();

  ///Singleton
  static NetworkRequestLauncher shared = NetworkRequestLauncher._internal();
  PrimaryProvider primaryProvider = PrimaryProvider();

  Future<T?> launch<T>(
      {required Future<T> Function() task,
        bool showLoading = false,
        bool showInternetConnectPopup = false,
        Future<T> Function()? retry}) async {
    final bool hasConnectivity =
    await ConnectionManager.shared.internetConnectionAvailable();
    if (hasConnectivity) {
      ///Show Loader
      if (showLoading) {
        primaryProvider.showLoader();
      }

      final T result = await task();

      ///Hide Loader
      if (showLoading) {
        primaryProvider.hideLoader();
      }

      return result;
    } else if (showInternetConnectPopup) {
      await primaryProvider.showInternetConnectionError();
      return launch<T>(
          task: task,
          showLoading: showLoading,
          showInternetConnectPopup: showInternetConnectPopup);
    }

    return null;
  }
}
