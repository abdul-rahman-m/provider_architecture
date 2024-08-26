import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider_stub/res/app_colors.dart';
import 'package:provider_stub/res/app_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final TextStyle? textFont;
  final String buttonImage;
  final double? radius;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textFont,
    this.radius,
    this.buttonImage = "",
  });

  // Creates a button with only text
  Widget buttonWithText(context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        textStyle: textFont ?? AppFonts.textRegular17,
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        foregroundColor: backgroundColor == AppColors.primaryColor
            ? Colors.white
            : AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 16),
            // Set custom radius here
          ),
          side: const BorderSide(
            color: AppColors.primaryColor,
            width: 1,
          ), // Border color and width
        ),
      ),
      child: Text(text, style: textFont ?? AppFonts.textRegular17),
    );
  }

  // Creates a button with an image and text
  Widget buttonWithImage(context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        textStyle: textFont ?? AppFonts.textRegular17,
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        foregroundColor: backgroundColor == AppColors.primaryColor
            ? Colors.white
            : AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 16),
            // Set custom radius here
          ),
          side: const BorderSide(
            color: AppColors.primaryColor,
            width: 1,
          ), // Border color and width
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            height: 24,
            width: 24,
            buttonImage,
            color: backgroundColor == AppColors.primaryColor
                ? Colors.white
                : AppColors.primaryColor,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(text, style: textFont ?? AppFonts.textRegular17),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      width: double.infinity,
      child: buttonImage.isEmpty
          ? buttonWithText(context)
          : buttonWithImage(context),
    );
  }
}
