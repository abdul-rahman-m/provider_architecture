import 'dart:io';

import 'package:dio/dio.dart';
import 'package:provider_stub/remote/rest_apis/base/base_rest_api.dart';
import 'package:provider_stub/remote/rest_apis/errors/rest_api_errors.dart';
import 'package:provider_stub/remote/rest_apis/rest_http_file/rest_http_file.dart';
import 'package:provider_stub/remote/network/http_client.dart';

class RestHttpClient {
  List<RestHttpFile>? httpFiles;  // List of files for multipart requests
  String? httpFilesKey;  // Key for multipart file data

  // Constructor
  RestHttpClient({this.httpFiles, this.httpFilesKey});

  final _httpClient = HttpClient();  // Instance of the HTTP client

  // Determines if the request is multipart based on the presence of httpFilesKey
  bool get isMultiPartRequest {
    return httpFilesKey != null && httpFilesKey!.isNotEmpty;
  }

  // Executes an HTTP request and handles the response
  Future<Map<String, dynamic>> request({
    required String url,  // URL for the request
    required RestApiMethod method,  // HTTP method (GET, POST, etc.)
    Map<String, String>? headers,  // Optional headers
    dynamic parameters,  // Optional parameters for the request
  }) async {
    try {
      late final Response<Map<String, dynamic>> response;
      final options = Options(headers: headers);  // Sets up request options

      // Switch based on the HTTP method
      switch (method) {
        case RestApiMethod.get:
          response = await _httpClient.dio.get<Map<String, dynamic>>(url, options: options);
          break;
        case RestApiMethod.put:
          response = await _httpClient.dio.put<Map<String, dynamic>>(
            url,
            data: isMultiPartRequest
                ? _prepareFormData(parameters: parameters ?? {}, files: httpFiles!, key: httpFilesKey!)
                : parameters,
            options: options,
          );
          break;
        case RestApiMethod.post:
          response = await _httpClient.dio.post<Map<String, dynamic>>(
            url,
            data: isMultiPartRequest
                ? _prepareFormData(parameters: parameters ?? {}, files: httpFiles!, key: httpFilesKey!)
                : parameters,
            options: options,
          );
          break;
        case RestApiMethod.delete:
          response = await _httpClient.dio.delete<Map<String, dynamic>>(url, data: parameters, options: options);
          break;
      }
      return response.data ?? {};  // Return response data or an empty map
    } on DioException catch (e) {
      // Handle exceptions
      if (e.error is SocketException) {
        return _noInternetConnectionResponse();  // Return error response for no internet connection
      } else if (e.response != null && e.response!.data != null && e.response!.data is Map) {
        return e.response!.data as Map<String, dynamic>;  // Return error response from the server
      } else {
        return {};  // Return an empty map for unknown errors
      }
    }
  }

  // Returns a standard response for no internet connection
  Map<String, dynamic> _noInternetConnectionResponse() {
    return {
      "code": 000,
      "data": null,
      "message": ApiErrors.internetConnectionError.key,
    };
  }

  // Prepares FormData for multipart file uploads
  FormData _prepareFormData({
    required Map<String, dynamic> parameters,
    required List<RestHttpFile> files,
    required String key,
  }) {
    parameters[key] = files
        .map((file) => MultipartFile.fromFileSync(file.filePath, filename: file.extension))
        .toList();  // Convert files to MultipartFile
    return FormData.fromMap(parameters);  // Create FormData from parameters
  }
}
