import 'package:provider_stub/remote/network/constants.dart';
import 'package:provider_stub/remote/rest_apis/errors/rest_api_errors.dart';
import 'package:provider_stub/remote/rest_apis/response/rest_response.dart';

class RepoData<T> {
  final RestApiResponse<T> responseData;
  RepoData({required this.responseData});

  T? get data {
    return responseData.data;
  }

  bool get hasNullResponse {
    return data == null &&
        responseData.message == null &&
        responseData.code != 0;
  }

  bool get hasData {
    return data != null;
  }

  bool get hasInternetConnectionError {
    return responseData.message != null &&
        responseData.message!.isNotEmpty &&
        responseData.message == ApiErrors.internetConnectionError.key;
  }

  bool get hasError {
    return data == null && responseData.message != null;
  }

  String get errorMessage {
    return responseData.message ?? "error";
  }

  bool get isSuccessCode {
    print(responseData.code);
    return responseData.code == NetworkConstants.successCode;
  }

  bool get createStatus {
    return responseData.code == NetworkConstants.createCode;
  }
}
