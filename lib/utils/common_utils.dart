class CommonUtils {
  // Converts a date string from "dd/MM/yyyy" format to "yyyy-MM-dd" format
  static String? convertToRequiredDateFormat(String value) {
    if (value.isNotEmpty) {
      List<String> parts = value.split('/');
      int day = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int year = int.parse(parts[2]);
      // Format the date in the "yyyy-MM-dd" format
      String formattedDate =
          "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
      return formattedDate;
    }
    return null;
  }
}
