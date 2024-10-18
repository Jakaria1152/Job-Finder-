import 'package:flutter/material.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';

class HeadingWidget extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const HeadingWidget({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ReusableText(text: text, style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 20
        )),
        GestureDetector(
          onTap: onTap,
          child: const ReusableText(text: "View all", style: TextStyle(
            color: Colors.deepOrange,
              fontWeight: FontWeight.w500,
              fontSize: 18
          )),
        )
      ],
    );
  }
}
