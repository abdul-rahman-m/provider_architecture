class RestApiResponse<T> {
  final int code;
  final T? data;
  final String? message;

  RestApiResponse(this.code, this.data, this.message);

  static RestApiResponse<T> fromJson<T>(
      Map<String, dynamic> json, T Function(dynamic json) parser) {
    final data = json["data"];
    return RestApiResponse<T>(json["code"] ?? 000,
        data != null ? parser(data) : null, json["message"]);
  }

  static RestApiResponse<T> fromMockJson<T>(
      Map<String, dynamic> json, T? model) {
    return RestApiResponse<T>(json["code"] ?? 000, model, json["message"]);
  }
}
