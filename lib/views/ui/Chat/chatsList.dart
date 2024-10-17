import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:job_finder_app/controllers/chat_provider.dart';
import 'package:job_finder_app/model/response/Chat/get_chat.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';
import 'package:job_finder_app/views/common/search_loader.dart';
import 'package:job_finder_app/views/ui/Chat/chat_page.dart';
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
          ),
        ),
      ),
      body: Consumer<ChatNotifier>(
        builder: (context, chatNotifier, child) {
          // first time call so that get data from backend to List
          chatNotifier.getChats();
          chatNotifier.getPrefs();
          print(chatNotifier.userId);
          return FutureBuilder<List<GetChats>>(
            future: chatNotifier
                .chats, // access List which get data backend from before
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error is: ${snapshot.error}'),
                );
              } else if (snapshot.data!.isEmpty) {
                return SearchLoading(text: "No Chat's Available");
              } else {
                var chats = snapshot.data;
                // print(chats?[0].chatName);
                // print(chats?[0].isGroupChat);
                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  itemCount: chats?.length,
                  itemBuilder: (context, index) {
                    final chat = chats?[index];
                    //     (user) => user.id != chatNotifier.userId:
                    // This lambda function takes each user from the list and checks if their id is not equal to the userId stored in chatNotifier.
                    // In simple terms, it keeps only the users whose id is different from chatNotifier.userId.
                    var user = chat?.users
                        .where((user) => user.id != chatNotifier.userId).toList(); //be careful to use toList() otherwise bad state error get

                    // print(">>>");
                    // print(user!.length);
                    // if (user != null && user.isNotEmpty) {
                    //   print(user.first.username);
                    //   print(user.first.profile);
                    // } else {
                    //   print("No valid users found.");
                    // }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: GestureDetector(
                        //can click each chat list
                        onTap: () {
                          Get.to(()=>ChatPage(id: chat.id,
                          title: user.first.username,
                            profile: user.first.profile,
                            user: [
                              chat.users[0].id,
                              chat.users[1].id,
                            ],
                          ));
                        },
                        child: Container(
                          height: size.height * 0.1,
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 4),
                            minLeadingWidth: 0,
                            minVerticalPadding: 0,
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: user?.isNotEmpty == true
                                  ? NetworkImage(user!.first.profile)
                                  : AssetImage('assets/images/profile.jpg') as ImageProvider,  // user na pele by default amar profile picture ta show korbe
                            ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(text: user!.first.username,
                                    style: TextStyle(fontSize: 16,
                                    color: Colors.black, fontWeight: FontWeight.w600)),
                                SizedBox(height: 5,),
                                ReusableText(text: chat?.latestMessage?.content ?? "",
                                    style: TextStyle(fontSize: 16,
                                        color: Colors.blueGrey, fontWeight: FontWeight.w600)),

                              ],
                            ),
                            trailing: Padding(padding: EdgeInsets.only(right: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // message updated time show korbe
                                ReusableText(text: chatNotifier.msgTime(chat!.updatedAt.toString()),
                                    style: TextStyle(fontSize: 12,
                                        color: Colors.black, fontWeight: FontWeight.normal)),
                                
                                Icon(  // icon show based on incoming or outgoing
                                    chat.latestMessage?.sender.id == user.first.id ?
                                    Ionicons.arrow_forward_circle_outline:
                                    Ionicons.arrow_back_circle_outline)
                              ],
                            ),),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
