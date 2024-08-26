import 'package:provider_stub/remote/rest_apis/base/base_rest_api.dart';

class ConsumerAppEndPoint extends AppEndPoint {
  const ConsumerAppEndPoint._internal(super.key, super.method,
      {super.authRequired});

  static ConsumerAppEndPoint loginUrl = const ConsumerAppEndPoint._internal(
      "objects", RestApiMethod.post,
      authRequired: false);

  @override
  bool get isMultiPartRequest {
    return !(multiPartKey == null);
  }

  @override
  String? get multiPartKey {
    // For image upload of feedback page, uncomment if needed
    // if (this == ConsumerAppEndPoint.postFeedBackUrl) {
    //   return "images";
    // }
    return null;
  }
}
