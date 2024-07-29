import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color? color;
  final double? height;
  const CustomOutlineButton({super.key, this.onTap, required this.text, this.color, this.height});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(style: OutlinedButton.styleFrom(
      // backgroundColor: color,
      shape: RoundedRectangleBorder()
    ),onPressed: onTap, child: Text(text,style: TextStyle(color: color),));
  }
}
