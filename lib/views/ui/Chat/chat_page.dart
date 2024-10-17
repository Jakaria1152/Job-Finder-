import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/app_bar.dart';

class ChatPage extends StatefulWidget {
  final String title;
  final String id;
  final String profile;
  final List<String> user;
  const ChatPage({super.key, required this.title, required this.id, required this.profile, required this.user});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppbar(
          text: widget.title,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: (){
                Get.back();  // back previous page
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          actions: [
            Padding(padding: EdgeInsets.all(8),
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.profile),
                ),
                Positioned(
                    right: 3,
                    child: CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.green,
                ))
              ],
            ),
            )
          ],
        ),
      ),
    );
  }
}
