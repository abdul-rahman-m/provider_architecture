
import 'dart:convert';

import 'package:provider_stub/remote/rest_apis/http_client/rest_http_client.dart';
import 'package:provider_stub/remote/rest_apis/response/rest_response.dart';
import 'package:provider_stub/remote/rest_apis/rest_http_file/rest_http_file.dart';
import 'package:provider_stub/res/api_constants.dart';

abstract class AppEndPoint {
  final String key;
  final RestApiMethod requestMethod;
  final bool authRequired;
  const AppEndPoint(this.key, this.requestMethod, {this.authRequired = true});

  bool get isMultiPartRequest;
  String? get multiPartKey;

}

abstract class RestApi {
  final AppEndPoint endPoint;

  ///Constructor Properties
  List<dynamic> paths;
  Map<String, dynamic> queryParameters;
  final Map<String, String> additionalHeaders;
  List<RestHttpFile> Function()? getHttpFiles;
  Map<String, String>? overridingHeaders;

  ///Constructor
  RestApi({
    required this.endPoint,
    this.getHttpFiles,
    this.paths = const [],
    this.queryParameters = const {},
    this.additionalHeaders = const {},
  });

  ///Parameters
  dynamic _parameters = {};

  //getter
  dynamic get requestParameters {
    return _parameters;
  }

  bool get isAuthTokenRequired {
    return endPoint.authRequired;
  }

  bool get isMultiPartRequest {
    return endPoint.isMultiPartRequest;
  }

  String? get multiPartParameterKey {
    return endPoint.multiPartKey;
  }

  //setter
  set requestParameters(dynamic parameters) {
    _parameters = parameters;
  }

  List<RestHttpFile>? getFiles() {
    return getHttpFiles != null && getHttpFiles!().isNotEmpty
        ? getHttpFiles!()
        : [];
  }

  Map<String, String> getHeaders() {
    Map<String, String> headers = {
      "Content-Type":
          isMultiPartRequest ? "multipart/form-data" : "application/json",
    };
    //Todo: handle auth session
    // if (isAuthTokenRequired &&
    //     Storage.instance.hasSession &&
    //     Storage.instance.authToken.isNotEmpty) {
    //   //append auth token with request
    //   print("AuthenicationToken :");
    //   print(Storage.instance.authToken);
    //   headers["x-auth-token"] = Storage.instance.authToken;
    // }

    ///platform headers
    headers["platform"] = 'customer';

    ///check if additional headers exist add them
    if (additionalHeaders.isNotEmpty) {
      headers.addAll(additionalHeaders);
    }

    ///check if there are some headers that need to be override
    if (overridingHeaders != null && overridingHeaders!.isNotEmpty) {
      headers.addAll(overridingHeaders!);
    }

    return headers;
  }

  RestApiMethod getRequestMethod() {
    return endPoint.requestMethod;
  }

  String getUrl() {
    /// getBaseUrl based on the current
    String baseUrl = ApiConstants.baseUrl;

    String url = baseUrl.endsWith("/") ? endPoint.key : "/${endPoint.key}";
    //check for paths
    for (dynamic path in paths) {
      ///This condition check has been done because some of the non-revamped path has the '/' which remove will affect the revamp module,once the revamp completed the function can be removed.
      url = url.endsWith("/") ? "$url$path" : "$url/$path";
    }

    //query parameters
    final queryString = Uri(queryParameters: queryParameters).query;
    if (queryString.isNotEmpty) {
      url = "$url?$queryString";
    }

    return baseUrl + url;
  }

  Future execute<T>(
      {T Function(dynamic json)? parser}) async {
    final restHttpClient = isMultiPartRequest
        ? RestHttpClient(
            httpFiles: getFiles(), httpFilesKey: multiPartParameterKey)
        : RestHttpClient();

    final json = await restHttpClient.request(
        url: getUrl(),
        method: getRequestMethod(),
        parameters: requestParameters,
        headers: getHeaders());

    // final parsedResponse = RestApiResponse.fromJson<T>(
    //     json, (data) => parser != null ? parser(data) : data);
    return parser!(json);
  }

  Future<RestApiResponse<List<T>>> executeForList<T>(
      {List<T> Function(List<dynamic> json)? parser}) async {
    final restHttpClient = isMultiPartRequest
        ? RestHttpClient(
            httpFiles: getFiles(), httpFilesKey: multiPartParameterKey)
        : RestHttpClient();
    final json = await restHttpClient.request(
        url: getUrl(),
        method: getRequestMethod(),
        parameters: requestParameters,
        headers: getHeaders());
    final parsedResponse = RestApiResponse.fromJson<List<T>>(
        json, (data) => parser != null ? parser(data) : data);
    return parsedResponse;
  }
}

enum RestApiMethod { get, put, post, delete }
