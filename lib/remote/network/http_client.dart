import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class HttpClient {
  HttpClient();
  Dio get dio => _getDio();
  Dio _getDio() {
    final options = BaseOptions(
        baseUrl: '', // this baseurl is based on  flavor used in remote config
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout:  const Duration(seconds: 20),
        receiveDataWhenStatusError: true);

    final dio = Dio(options);

    dio.interceptors.addAll(<Interceptor>[_loggingInterceptor()]);

    return dio;
  }

  //Dio instance may have interceptor(s) by which you can intercept requests/responses/errors
  // before they are handled by then or catchError.
  Interceptor _loggingInterceptor() {
    return InterceptorsWrapper(onRequest: (options, handler) {
      log("--> ${options.method} ${"${options.baseUrl}${options.path}"}");
      log('Headers:');
      options.headers.forEach((k, dynamic v) => log('$k: $v'));
      log('queryParameters:');
      options.queryParameters.forEach((k, dynamic v) => log('$k: $v'));
      log(
        '--> END ${options.method}',
      );

      // Do something before request is sent
      log('\n'
          '-- headers --\n'
          '${options.headers.toString()} \n'
          '-- request -- \n -->body '
          '${options.data} \n'
          '');

      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    }, onResponse: (response, handler) {
      // Do something with response data
      log('\n'
          'Response : ${response.requestOptions.uri} \n'
          '-- headers --\n'
          '${response.headers.toString()} \n'
          '-- response --\n'
          '${jsonEncode(response.data)} \n'
          '');

      return handler.next(response); // continue
    }, onError: (error, handler) {
      // Do something with response error
      return handler.next(error); //continue
    });
  }
}
