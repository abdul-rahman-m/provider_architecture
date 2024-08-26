// status code

class NetworkConstants {
  static const successCode = 200;
  static const createCode = 201;
  static const badRequestCode = 400;
  static const unAuthorizedCode = 401;
  static const userAccessNotAllowedCode = 403;
  static const resourceNotExistCode = 404;
  static const internalServerErrorCode = 500;
  static const internetCode = 502;
  static const serverUnAvailableCode = 503;

//error strings
  static const success = "Success";
  static const failure = "Failure";
  static const authenticationFailed = "Authentication failed.";
  static const useAccessNotAllowed =
      "The authenticated user is not allowed to access this feature.";
  static const resourceDoesExist = "The requested resource does not exist.";
  static const internalServerError = "Internal server error.";
  static const serverUnAvailable = "Server unavailable.";
  static const privacyPolicyText = "privacy-and-policy";
  static const heaterText =
      "document.getElementsByTagName('header')[0].style.display='none'";
  static const footerText =
      "document.getElementsByTagName('footer')[0].style.display='none'";
  static const centerText =
      "document.getElementsByClassName('col-xs-12 text-center static__content-title')[0].style.display='none'";

}
