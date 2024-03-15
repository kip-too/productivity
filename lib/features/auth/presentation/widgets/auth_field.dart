import 'package:flutter/material.dart';
import 'package:todo_list_app/core/theme/app_pallete.dart';
import 'package:email_validator/email_validator.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;
  final bool isEmailField;
  final bool isPasswordField;

  const AuthField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
    this.isEmailField = false,
    this.isPasswordField = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: 'Kalam',
        ), // Add styling here
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Adjust padding as needed
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // Set border radius
          borderSide:  const BorderSide(
            color: AppPallete.borderColor, // Use your palette color
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // Set border radius
          borderSide: const BorderSide(
              color: AppPallete.borderColor // Use your palette color (optional)
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing!";
        }
        if (isEmailField && !EmailValidator.validate(value)) {
          return "Invalid email format";
        }
        if (isPasswordField && value.length < 6) {
          return "Password must be at least 6 characters long";
        }
        return null;
      },
      obscureText: isObscureText,
    );
  }
}
