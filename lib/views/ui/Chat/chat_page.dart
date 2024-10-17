import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:job_finder_app/controllers/chat_provider.dart';
import 'package:job_finder_app/model/response/Messaging/messaging_res.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';
import 'package:job_finder_app/views/ui/Chat/widget/chat_textfield.dart';
import 'package:provider/provider.dart';

import '../../../services/helper/messaging_helper.dart';
import '../../common/app_bar.dart';
import '../../common/search_loader.dart';

class ChatPage extends StatefulWidget {
  final String title;
  final String id;
  final String profile;
  final List<String> user;
  const ChatPage(
      {super.key,
      required this.title,
      required this.id,
      required this.profile,
      required this.user});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  int offset = 1;
  late Future<List<ReceivedMessages>> msgList;
  // get message
  void getMessages() {
    msgList = MessagingHelper.getMessages(widget.id, offset);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessages(); // call get Message
  }

  @override
  Widget build(BuildContext context) {
    // device width and height
    final width = Get.width;
    final height = Get.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppbar(
          text: widget.title,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                Get.back(); // back previous page
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(8),
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
      body: Consumer<ChatNotifier>(
        builder: (context, chatNotifier, child) {
          return SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Expanded(
                    child: FutureBuilder<List<ReceivedMessages>>(
                  // get data for message when open this chat page
                  future: msgList,
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
                      return SearchLoading(text: "You do not have message");
                    } else {
                      final chats = snapshot.data;
                      return ListView.builder(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        itemCount: chats?.length,
                        itemBuilder: (context, index) {
                          final data = chats?[index];

                          return Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 12),
                            child: Column(
                              children: [
                                ReusableText(
                                    text: chatNotifier.msgTime(
                                        data!.chat!.updatedAt.toString()),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal)),
                                SizedBox(
                                  height: 15,
                                ),
                                ChatBubble(
                                  alignment:
                                      data.sender.id == chatNotifier.userId
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                  backGroundColor:
                                      data.sender.id == chatNotifier.userId
                                          ? Colors.deepOrangeAccent
                                          : Colors.lightBlue,
                                  elevation: 0,
                                  clipper: ChatBubbleClipper4(
                                      radius: 8,
                                      type:
                                          data.sender.id == chatNotifier.userId
                                              ? BubbleType.sendBubble
                                              : BubbleType.receiverBubble),
                                  child: Container(
                                    constraints:
                                        BoxConstraints(maxWidth: width * 0.8),
                                    child: ReusableText(
                                        text: data.content,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                )
                ),
                // make sender send message box
                MessageTextField(
                  messageController: messageController,
                  suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.send,size: 24,
                    color: Colors.lightBlue,)),)
              ],
            ),
          ));
        },
      ),
    );
  }
}


