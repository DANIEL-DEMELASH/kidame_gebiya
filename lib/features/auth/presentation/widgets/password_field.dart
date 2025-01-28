import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:kidame_gebiya/app_constant.dart';

class BuildPasswordField extends StatefulWidget {
  const BuildPasswordField({super.key, required this.passwordController});
  final TextEditingController passwordController;

  @override
  State<BuildPasswordField> createState() => _BuildPasswordFieldState();
}

class _BuildPasswordFieldState extends State<BuildPasswordField> {
  bool isPasswordHidden = true;
  
  void _togglePasswordVisibility() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      obscureText: isPasswordHidden,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: greyColor),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: greyColor),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: greyColor),
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: const Icon(Icons.lock_outlined, size: 28, color: darkGreyColor),
        hintText: 'Password',
        hintStyle: const TextStyle(fontSize: 16),
        labelStyle: const TextStyle(fontSize: 16),
        suffixIcon: IconButton(
          onPressed: _togglePasswordVisibility,
          icon: Icon(
            isPasswordHidden ? FeatherIcons.eyeOff : FeatherIcons.eye,
            color: darkGreyColor,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password cannot be empty';
        }
        if (value.trim().length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }
}

