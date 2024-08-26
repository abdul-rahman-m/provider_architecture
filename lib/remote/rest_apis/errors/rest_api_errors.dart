class ApiErrors {
  final String key;
  const ApiErrors._({required this.key});

  static const ApiErrors internetConnectionError =
      ApiErrors._(key: "error_no_internet_connection");
}
