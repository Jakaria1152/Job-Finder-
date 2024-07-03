import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        ZoomDrawer.of(context)?.toggle();
      },
      child: SvgPicture.asset("assets/icon/menu.svg",width: 30,height: 30,),
    );
  }
}
