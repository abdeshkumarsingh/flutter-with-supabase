import 'package:flutter/material.dart';

class AuthTextfield extends StatelessWidget {
  final String hintText;
  final Widget? suffix;
  final TextEditingController? controller;
  final bool obscuretext;
  final IconData? prefixIcon;
  final void Function(String)? onChanged;

  const AuthTextfield({
    Key? key,
    required this.hintText,
    this.controller,
    this.suffix,
    this.onChanged,
    this.obscuretext = true,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscuretext,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffix: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20)
      ),
      onChanged: onChanged,
    );
  }
}
