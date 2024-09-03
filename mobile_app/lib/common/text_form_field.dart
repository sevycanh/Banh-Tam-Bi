import 'package:flutter/material.dart';
import 'package:mobile_app/configs/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.keyboardType,
      this.validator,
      this.suffixIcon,
      this.obscureText});

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          filled: true, // bậc màu nền
          fillColor: Color(AppColors.kLightGrey.value), // gán màu
          label: Text(hintText),
          labelStyle: TextStyle(color: Color(AppColors.kDark.value)),
          hintText: hintText,
          suffixIcon: suffixIcon,
          hintStyle: TextStyle(
              fontSize: 14,
              color: Color(AppColors.kDarkGrey.value),
              fontWeight: FontWeight.w500),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.red, width: 0.5)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.transparent, width: 0)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.red, width: 0.5)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                  color: Color(AppColors.kDarkGrey.value), width: 0.5)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.transparent, width: 0.5)),
          border: InputBorder.none),
      controller: controller,
      cursorHeight: 25, //điều chỉnh kích thước của con trỏ
      cursorColor: const Color.fromARGB(255, 27, 27, 27),
      style: TextStyle(
          fontSize: 16,
          color: Color(AppColors.kDark.value),
          fontWeight: FontWeight.w500),
      validator: validator,
    );
  }
}
