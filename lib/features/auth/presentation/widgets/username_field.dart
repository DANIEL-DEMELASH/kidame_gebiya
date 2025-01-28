import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:kidame_gebiya/app_constant.dart';

Widget buildUsernameField(TextEditingController usernameController) {
    return TextFormField(
      controller: usernameController,
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
        prefixIcon: const Icon(FeatherIcons.user, size: 28, color: darkGreyColor),
        hintText: 'Username',
        hintStyle: const TextStyle(fontSize: 16),
        labelStyle: const TextStyle(fontSize: 16),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Username cannot be empty';
        }
        if (value.trim().length < 3) {
          return 'Username must be at least 3 characters';
        }
        return null;
      },
    );
  }
