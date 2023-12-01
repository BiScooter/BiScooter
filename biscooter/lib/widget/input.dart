// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final double width;
  final String label;
  final TextEditingController controller;
  final TextEditingController password;
  const Input({
    super.key,
    required this.width,
    required this.label,
    required this.controller,
    required this.password
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 4.0),
      child: SizedBox(
        width: width, // Set the width
        height: 50, // Set the height
        child: TextFormField(
          keyboardType: (label == "Telephone")
              ? TextInputType.phone
              : (label == "Email")
                  ? TextInputType.emailAddress
                  : (label == "Password" || label == "Confirm Password")
                      ? TextInputType.visiblePassword
                      : TextInputType.text,
          obscureText: label == "Password" || label == "Confirm Password",

          //styling of the input field
          decoration: InputDecoration(
            border:
                const UnderlineInputBorder(), // This gives a border at the bottom
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.4,
              ), // This gives a border at the bottom when enabled
            ),
            // labelText: label,
            hintText: label,
            hintStyle:
                const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            errorStyle:
                const TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
          ),

          // the different validations
          validator: (value) {
            if (value != null && value.isEmpty) return "Enter $label";

            if (label == "Email") {
              const pattern =
                  r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                  r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                  r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                  r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                  r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                  r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                  r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
              final bool regex = RegExp(pattern).hasMatch(value!);
              if (!regex) return "Enter a valid email";
            } else if (label == "Username") {
              const pattern = r'^[a-zA-Z0-9_]+$';
              final regex = RegExp(pattern);
              if (!regex.hasMatch(value!)) return "Invalid username";
            } else if (label == 'Telephone') {
              const pattern = r'^\d{11}$';
              final regex = RegExp(pattern);
              if (!regex.hasMatch(value!))
                return "Enter a valid 11 digit number";
            } else if (label == "Password") {
              const pattern = r'^\S{8,}$';
              final regex = RegExp(pattern);
              if (!regex.hasMatch(value!))
                return "Password must be at least 8 digits with no spaces";
            } else if (label == "Confirm Password") {
              if (controller.text != password.text)
                return "Password doesn't match";
            }
            return null;
          },

          controller: controller,
        ),
      ),
    );
  }
}
