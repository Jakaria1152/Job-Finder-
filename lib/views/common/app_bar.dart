import 'package:flutter/material.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';

class CustomAppbar extends StatelessWidget {
  final String? text;
  final Widget child;
  final List<Widget>? actions;
  const CustomAppbar({super.key, this.text, required this.child, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme:  const IconThemeData(),
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
        leadingWidth: 70.0,
      centerTitle: true,
      leading: child,
      actions: actions,
      // text null hole "" assign korbe
      title: ReusableText(text: text??"", style: const TextStyle(color: Colors.black,
      fontSize: 26,
        fontWeight: FontWeight.w600
      ),),


    );
  }
}
