import 'package:flutter/material.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';

class DrawerItem extends StatelessWidget {
  final IconData iconData;
  final String label;
  final Color color;
  const DrawerItem({super.key, required this.iconData, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: null,
      child: Container(
        margin: EdgeInsets.only(left: 20, bottom: 20),
        child: Row(
          children: [
        Icon(iconData,color: color,),
            SizedBox(width: 12,),
            ReusableText(text: label, style: TextStyle(color: color,fontSize: 12,fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
