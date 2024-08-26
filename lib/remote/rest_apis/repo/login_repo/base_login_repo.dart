import 'package:provider_stub/models/device.dart';
import 'package:provider_stub/remote/rest_apis/base/base_rest_api.dart';

abstract class BaseLoginRepo {

  // Performs a request to get device data using the provided RestApi and request body
  Future<DeviceResponse> getDeviceDataCall(
      RestApi restApi, Map<String, dynamic> body) async {

    restApi.requestParameters = body;  // Set the request parameters for the RestApi

    // Execute the RestApi request and parse the JSON response into a DeviceResponse
    DeviceResponse responseData = await restApi.execute(
        parser: (json) => DeviceResponse.fromJson(Map<String, dynamic>.from(json))
    );

    // Create a repository data object (commented out code for potential use)
    // final repoData = RepoData<DeviceResponse>(responseData: responseData);
    final repoData = responseData;  // Directly return the response data

    return repoData;  // Return the parsed device response
  }
}
