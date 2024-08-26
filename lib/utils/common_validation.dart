import 'package:provider_stub/utils/regex.dart';

class CommonValidation {
  // Validates email input
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(LocalInputRegex.email);
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Validates password input
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Common validator for generic input validation
  String? commonValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter data';
    }
    return null;
  }
}
