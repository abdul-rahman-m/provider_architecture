import 'package:provider_stub/models/device.dart';
import 'package:provider_stub/remote/api/consumer_enum_endpoint.dart';
import 'package:provider_stub/remote/api/consumer_rest_api.dart';
import 'package:provider_stub/remote/rest_apis/repo/login_repo/base_login_repo.dart';

class LoginRepo extends BaseLoginRepo {
  // Private constructor for singleton pattern
  LoginRepo._internal();

  // Singleton instance of LoginRepo
  static LoginRepo instance = LoginRepo._internal();

  // Fetches device data by calling the base class method with appropriate parameters
  Future<DeviceResponse> getDeviceData(DeviceRequest body) {
    return getDeviceDataCall(
      ConsumerRestApi(endPoint: ConsumerAppEndPoint.loginUrl),  // Create a new ConsumerRestApi with the login endpoint
      body.toJson(),  // Convert the DeviceRequest body to JSON
    );
  }
}
