import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider_stub/res/app_colors.dart';
import 'package:provider_stub/res/app_fonts.dart';
import 'package:provider_stub/res/app_styles.dart';
import 'package:provider_stub/utils/common_validation.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? prefixIcon;
  final String? suffixIcon;
  final bool isPassword;
  final bool skipValidation;
  final bool isFinalConfirmation;
  final bool? isMaxLines;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function()? onTapSuffix;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.keyboardType,
    this.onChanged,
    this.onTapSuffix,
    this.validator,
    this.isMaxLines,
    this.isFinalConfirmation = false,
    this.skipValidation = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  DateTime? _selectedDate;
  DateTime? _minDate;
  DateTime? _maxDate;

  // Toggle password visibility
  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Format date to dd/mm/yyyy
  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  // Display date picker and update text field with selected date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: _minDate ?? DateTime(1900),
      lastDate: _maxDate ?? DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.controller.text = _formatDate(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword && _obscureText,
      obscuringCharacter: "*",
      readOnly: widget.keyboardType == TextInputType.datetime ? true : false, // Disable editing directly in the text field
      enableInteractiveSelection: widget.keyboardType == TextInputType.datetime ? false : null,
      enableSuggestions: false,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      onTap: () {
        if (widget.keyboardType == TextInputType.datetime) {
          _selectDate(context);
        }
      },
      maxLines: widget.isMaxLines ?? false ? 2 : 1,
      decoration: widget.isFinalConfirmation
          ? InputDecoration.collapsed(hintText: widget.hintText)
          : InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon != null
            ? Container(
          height: 10,
          width: 10,
          margin: const EdgeInsets.only(left: 16, right: 10),
          child: Image.asset(widget.prefixIcon!),
        )
            : null,
        border: FieldBorderStyles.fieldBorder,
        enabledBorder: FieldBorderStyles.enabledFieldBorder,
        focusedBorder: FieldBorderStyles.focusedFieldBorder,
        hintStyle: AppFonts.textRegular17,
        labelStyle: AppFonts.textRegular17,
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: _toggleVisibility,
        )
            : widget.suffixIcon != null
            ? GestureDetector(
          onTap: widget.onTapSuffix,
          child: Container(
            height: 5,
            width: 5,
            margin: const EdgeInsets.only(right: 16, left: 10),
            child: Image.asset(
              widget.suffixIcon!,
              color: AppColors.primaryColor,
            ),
          ),
        )
            : null,
        suffixIconColor: widget.onTapSuffix != null ? AppColors.primaryColor : null,
      ),
      validator: widget.skipValidation ? null : widget.validator ?? CommonValidation().commonValidator,
    );
  }
}
