import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';
import 'package:job_finder_app/views/ui/homePage.dart';
import 'package:job_finder_app/views/ui/login_page.dart';
import 'package:job_finder_app/views/ui/widget/devicesInfo.dart';

import '../common/app_bar.dart';
import '../common/drawer/drawerWidget.dart';

class DeviceManagementPage extends StatelessWidget {
  const DeviceManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String date = DateTime.now().toString();
    var loginDate = date.substring(0,11);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppbar(
          text: 'Device Management',
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: DrawerWidget(),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'You are logged in into your account on these device',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(height: 50,),
                  DevicesInfo(
                      location: 'Jashore',
                      device: 'VivoBook',
                      platform: 'Windows',
                      date: loginDate,
                      ipAddress: '192.168.25.26'),
                  SizedBox(height: 50,),
                  DevicesInfo(
                      location: 'Bangladesh',
                      device: 'VivoBook',
                      platform: 'Linux',
                      date: loginDate,
                      ipAddress: '192.168.25.26')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                onTap: (){
                  Get.to(LoginPage());
                },
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ReusableText(text: 'Sign Out of all devices', style: TextStyle(
                    fontSize: 16, color: Colors.orange, fontWeight: FontWeight.w600
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
