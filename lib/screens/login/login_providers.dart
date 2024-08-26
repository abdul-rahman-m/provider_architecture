import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider_stub/models/device.dart';
import 'package:provider_stub/providers/primary_provider.dart';
import 'package:provider_stub/remote/rest_apis/base/network_request_launcher.dart';
import 'package:provider_stub/remote/rest_apis/repo/login_repo/login_repo.dart';

class LoginProviders with ChangeNotifier {
  /// Data
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  bool _rememberMe = false; // Initial state of remember me checkbox
  bool _loading = false;

  /// Functions and Constructors
  // Initializes the instance and loads user preferences.
  LoginProviders() {
    emailController.text = dotenv.env['USER1_EMAIL']!;
    getDeviceData();
  }

  // Validates the form, attempts login, saves preferences, and navigates to the loader screen if successful.
  void loginButtonFunctions(BuildContext context, PrimaryProvider primaryProvider) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      // Add your login logic here
    }
  }

  // Fetches device data and handles loading state.
  getDeviceData() async {
    loading = true;
    final data = await NetworkRequestLauncher.shared.launch<DeviceResponse>(
      task: () async => await _callGetUserModel(
        DeviceRequest(
          name: "Mac 134",
          data: DeviceDetails(
            cpuModel: "M1 Chip",
            hardDiskSize: "500 GB",
            price: 30000,
            year: 1998,
          ),
        ),
      ),
      showLoading: false,
      showInternetConnectPopup: false,
    );

    loading = false;

    print(data?.name);
  }

  // Makes an API call to get device data
  Future<DeviceResponse> _callGetUserModel(DeviceRequest data) async {
    final repoData = await LoginRepo.instance.getDeviceData(data);
    return repoData;
  }

  /// Getters and Setters
  TextEditingController get emailController => _emailController;

  set emailController(TextEditingController value) {
    if (value == _emailController) return;
    _emailController = value;
    notifyListeners();
  }

  TextEditingController get passwordController => _passwordController;

  set passwordController(TextEditingController value) {
    if (value == _passwordController) return;
    _passwordController = value;
    notifyListeners();
  }

  GlobalKey<FormState> get formKey => _formKey;

  set formKey(GlobalKey<FormState> value) {
    if (value == _formKey) return;
    _formKey = value;
    notifyListeners();
  }

  bool get rememberMe => _rememberMe;

  set rememberMe(bool value) {
    if (value == _rememberMe) return;
    _rememberMe = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    if (value == _loading) return;
    _loading = value;
    notifyListeners();
  }
}
