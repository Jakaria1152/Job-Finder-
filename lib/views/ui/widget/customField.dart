import 'package:flutter/material.dart';
class CustomField extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  const CustomField({
    super.key,
    required this.search, required this.hintText, this.suffixIcon,
  });

  final TextEditingController search;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: search,

      decoration: InputDecoration(
        suffixIcon: suffixIcon,
          border: InputBorder.none,
          hintText: hintText.toUpperCase(),
          hintStyle: TextStyle(color: Colors.white, fontSize: 20, )
      ),


    );
  }
}