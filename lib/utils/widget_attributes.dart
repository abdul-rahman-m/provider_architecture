abstract class WidgetsAttributes {
  // Abstract getter for NoInternetConnectionAttributes
  abstract NoInternetConnectionAttributes noInternetConnectionAttributes;
}

class NoInternetConnectionAttributes {
  final String title;
  final String message;
  final String buttonText;

  NoInternetConnectionAttributes({
    required this.title,
    required this.message,
    required this.buttonText,
  });
}

class ConsumerWidgetsAttributes extends WidgetsAttributes {
  @override
  NoInternetConnectionAttributes noInternetConnectionAttributes =
  NoInternetConnectionAttributes(
    title: "Lost Connection",
    message: "Whoops no internet connection found.\nPlease check your connection.",
    buttonText: "Try Again",
  );
}
