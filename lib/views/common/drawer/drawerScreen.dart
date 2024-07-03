import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:job_finder_app/controllers/zoom_notifier.dart';
import 'package:provider/provider.dart';

import '../reusable_text.dart';

class DrawerScreen extends StatefulWidget {
  final ValueSetter indexSetter;
  const DrawerScreen({super.key, required this.indexSetter});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(
      builder: (context, zoomNotifier , child) {
        return GestureDetector(
          onDoubleTap: (){
            ZoomDrawer.of(context)?.toggle();
          },

          child: Scaffold(
            backgroundColor: Colors.lightBlue,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                DrawerItem(
                     Icons.home,
                     "Home",
                    0,
                    zoomNotifier.currentIndex==0?
                        Colors.white: Colors.grey
                ),
                DrawerItem(
                   Icons.chat,
                     "Chat",
                     1,
                     zoomNotifier.currentIndex==1?
                    Colors.white: Colors.grey
                ),
                DrawerItem(
                    Icons.bookmark,
                     "Bookmarks",
                     2,
                     zoomNotifier.currentIndex==2?
                    Colors.white: Colors.grey
                ),
                DrawerItem(
                    Icons.devices_outlined,
                    "Device management",
                     3,
                     zoomNotifier.currentIndex==3?
                    Colors.white: Colors.grey
                ),
                DrawerItem(
                     Icons.account_circle,
                    "Profile",
                     4,
                     zoomNotifier.currentIndex==4?
                    Colors.white: Colors.grey
                ),
              ],
            ),
          ),
        );

    },);
  }

  Widget DrawerItem(IconData iconData, String label, int index, Color color){
    return GestureDetector(
      onTap: (){
        widget.indexSetter(index);  // see carefully. because index value assign in final parameter
      },
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
