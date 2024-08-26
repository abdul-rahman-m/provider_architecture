import 'package:provider_stub/remote/rest_apis/base/base_rest_api.dart';

class ConsumerRestApi extends RestApi {
  ///Constructor
  ConsumerRestApi({
    required super.endPoint,
    super.getHttpFiles,
    super.paths,
    super.additionalHeaders,
    super.queryParameters,
  });
}
