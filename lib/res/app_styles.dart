import 'package:flutter/material.dart';
import 'package:provider_stub/res/app_colors.dart';

class FieldBorderStyles {
  static OutlineInputBorder fieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColors.textColor),
  );

  static OutlineInputBorder enabledFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColors.textColor),
  );

  static OutlineInputBorder focusedFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColors.primaryColor),
  );
}
