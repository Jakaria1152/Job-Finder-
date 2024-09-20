import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:job_finder_app/controllers/zoom_notifier.dart';
import 'package:job_finder_app/views/common/drawer/drawerScreen.dart';
import 'package:job_finder_app/views/ui/BookMarkPage.dart';
import 'package:job_finder_app/views/ui/chatspage.dart';
import 'package:job_finder_app/views/ui/device_management_page.dart';
import 'package:job_finder_app/views/ui/homePage.dart';
import 'package:job_finder_app/views/ui/auth/profile_page.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(
      builder: (context, zoomNotifier, child) {
return ZoomDrawer(
    borderRadius: 30,
    showShadow: true,
    angle: 0.0,
    slideWidth: 250,  // aita menu item side er width
    menuBackgroundColor: Colors.lightBlue,
    menuScreen: DrawerScreen(
      indexSetter: (index){

         zoomNotifier.currentIndex = index;
      },
    ),
    mainScreen: currentScreen()
);
      },

    );
  }
  Widget currentScreen(){
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    switch(zoomNotifier.currentIndex){
      case 0:
        return const HomePage();
      case 1:
        return const ChatsPage();
      case 2:
        return const BookMarkPage();
      case 3:
        return const DeviceManagementPage();
      case 4:
        return const ProfilePage();
      default:
        return const HomePage();

    }

  }
}
