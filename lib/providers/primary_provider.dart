import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider_stub/models/users.dart';
import 'package:provider_stub/res/app_strings.dart';
import 'package:provider_stub/utils/shared_prefs.dart';
import 'package:provider_stub/utils/widget_attributes.dart';
import 'package:provider_stub/widgets/loader.dart';

// Global key for navigator to manage navigation
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class PrimaryProvider with ChangeNotifier {
  ///Data
  bool? _isLoading = false; // Indicates if a loading state is active
  Users? _user; // Stores user information

  ///Functions
  // Loads the user's state from shared preferences
  Future<void> loadUserState() async {
    if (SharedPreferenceHelper.getUser() != null) {
      user = Users.fromMap(json.decode(SharedPreferenceHelper.getUser() ?? ""));
    }
    notifyListeners();
  }

  // Sets the loading state and notifies listeners
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Logs out the user and clears the user data from shared preferences
  void logout() async {
    user = null;
    SharedPreferenceHelper.removeParticularKey(AppStrings.userKey);
    notifyListeners();
  }

  // Displays a loading indicator if not already displayed
  void showLoader() {
    if (!_isLoading!) {
      appLoader();
      isLoading = true;
    }
  }

  // Hides the loading indicator if currently displayed
  void hideLoader() {
    if (_isLoading!) {
      navigatorKey.currentState?.pop();
      isLoading = false;
    }
  }

  // Displays an internet connection error message
  Future<void> showInternetConnectionError(
      {NoInternetConnectionAttributes? attributes}) async {
    appInternet();
    return;
  }

  ///Getter and Setter
  bool get isLoading => _isLoading ?? false; // Returns current loading state

  set isLoading(bool? value) {
    if (value == _isLoading) return;
    _isLoading = value;
    notifyListeners();
  }

  Users? get user => _user; // Returns current user information

  set user(Users? value) {
    if (value == _user) return;
    _user = value;
    notifyListeners();
  }
}
