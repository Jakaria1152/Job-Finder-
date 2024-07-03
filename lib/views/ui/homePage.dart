import 'package:flutter/material.dart';
import 'package:job_finder_app/views/common/app_bar.dart';
import 'package:job_finder_app/views/common/drawer/drawerWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
      child: CustomAppbar(
        actions: [
          Padding(padding: EdgeInsets.all(12),
          child: CircleAvatar(
            radius: 15,
           backgroundImage: AssetImage("assets/images/profile.jpg"),
          ),)
        ],
        
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: DrawerWidget(),
        ),),
      ),
    );
  }
}
