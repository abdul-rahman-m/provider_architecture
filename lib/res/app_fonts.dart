import 'package:flutter/material.dart';
import 'package:provider_stub/res/app_colors.dart';

class AppFonts {
  static const String helveticaBold = 'HelveticaNowDisplay-Bold';
  static const String helveticaExtraBold = 'HelveticaNowDisplay-ExtraBold';
  static const String helveticaMedium = 'HelveticaNowDisplay-Medium';
  static const String helveticaRegular = 'HelveticaNowDisplay-Regular';

  static const textRegular17 = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.normal,
    color: AppColors.textColor,
    fontFamily: AppFonts.helveticaRegular,
    letterSpacing: 0.5,
  );
}
