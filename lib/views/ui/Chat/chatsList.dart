import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/controllers/chat_provider.dart';
import 'package:job_finder_app/model/response/Chat/get_chat.dart';
import 'package:job_finder_app/views/common/search_loader.dart';
import 'package:provider/provider.dart';

import '../../common/app_bar.dart';
import '../../common/drawer/drawerWidget.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppbar(
         text: 'Chats',

          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: DrawerWidget(),
          ),),
      ),
      body: Consumer<ChatNotifier>(
        builder: (context, chatNotifier, child) {
        // first time call so that get data from backend to List
          chatNotifier.getChats();
        return FutureBuilder<List<GetChats>>(
            future: chatNotifier.chats, // access List which get data backend from before
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error is: ${snapshot.error}'),
              );
            }
            else if(snapshot.data!.isEmpty)
              {
                return SearchLoading(text: "No Chat's Available");
              }
            else{
              var chats = snapshot.data;
              // print(chats?[0].chatName);
              // print(chats?[0].isGroupChat);
              return ListView.builder(
                itemCount: chats?.length,
                itemBuilder: (context, index) {
                return Container(
                  height: size.height*0.26,
                  width: size.width,
                  color: Colors.orange,
                );
              },);
            }
          },
          );
      },),
    );
  }
}
