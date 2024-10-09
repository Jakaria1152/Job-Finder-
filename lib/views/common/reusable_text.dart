import 'package:flutter/cupertino.dart';

class ReusableText extends StatelessWidget {
  final String text;
  final TextStyle style;


  ReusableText({super.key, required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
