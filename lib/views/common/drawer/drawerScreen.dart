import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/controllers/zoom_notifier.dart';
import 'package:job_finder_app/views/common/drawer/drawerItem.dart';
import 'package:provider/provider.dart';

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
                    iconData: Icons.home,
                    label: "Home",
                    color: zoomNotifier.currentIndex==0?
                        Colors.white: Colors.grey
                ),
                DrawerItem(
                    iconData: Icons.chat,
                    label: "Chat",
                    color: zoomNotifier.currentIndex==1?
                    Colors.white: Colors.grey
                ),
                DrawerItem(
                    iconData: Icons.bookmark,
                    label: "Bookmarks",
                    color: zoomNotifier.currentIndex==2?
                    Colors.white: Colors.grey
                ),
                DrawerItem(
                    iconData: Icons.devices_outlined,
                    label: "Device management",
                    color: zoomNotifier.currentIndex==3?
                    Colors.white: Colors.grey
                ),
                DrawerItem(
                    iconData: Icons.account_circle,
                    label: "Profile",
                    color: zoomNotifier.currentIndex==4?
                    Colors.white: Colors.grey
                ),
              ],
            ),
          ),
        );

    },);
  }
}
