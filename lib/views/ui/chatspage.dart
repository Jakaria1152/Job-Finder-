import 'package:flutter/material.dart';

import '../common/app_bar.dart';
import '../common/drawer/drawerWidget.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppbar(
         text: 'Chat',

          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: DrawerWidget(),
          ),),
      ),
    );
  }
}
