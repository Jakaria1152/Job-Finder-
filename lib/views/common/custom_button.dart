
import 'package:flutter/material.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';

import '../../constants/constant.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final Color? color;
  const CustomButton({super.key, required this.text, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity*0.9,
        height: 50,
        color: Colors.deepOrange,
        child: Center(
          child: ReusableText(
            text: text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: color??Colors.white // color na dile by default white hobe
            ),
          ),
        ),
      ),
    );
  }
}
