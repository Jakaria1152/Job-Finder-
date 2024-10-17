import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/controllers/chat_provider.dart';
import 'package:job_finder_app/model/request/Message/send_message.dart';
import 'package:job_finder_app/model/response/Messaging/messaging_res.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';
import 'package:job_finder_app/views/ui/Chat/widget/chat_textfield.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO; // see carefully
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
  IO.Socket? socket;
  late Future<List<ReceivedMessages>> msgList;
  List<ReceivedMessages> messages = [];
  String receiver = '';
  final ScrollController _scrollController = ScrollController(); // very useful

  void handleNext(){
    _scrollController.addListener(()async{
      if(_scrollController.hasClients)
        {
          if(_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels)
            {
              print('<<><><><Loading><><><>>');
              if(messages.length >= 12)
                {
                  getMessages(offset++);
                  setState(() {

                  });
                }
            }
        }
    });
  }
  // get message
  void getMessages(int offset) {
    msgList = MessagingHelper.getMessages(widget.id, offset);
  }

  // get connection via socket
  void connect() {
    // make another controller object for chatNotifier
    var chatNotifier = Provider.of<ChatNotifier>(context, listen: false);
    socket = IO.io(
        'https://job-finderapp-backend-production.up.railway.app',
        <String, dynamic>{
          "transports": ['websocket'],
          "autoConnect": false
        });
    socket?.emit('setup', chatNotifier.userId);
    socket!.connect();
    socket!.onConnect((_) {
      print('Connect to Backend Successfully>>>');
      // check user online or not
      socket?.on('online-user', (userId) {
        // Removes the objects in the range from start to end, then inserts the elements of replacements at start.
        // final numbers = <int>[1, 2, 3, 4, 5];
        // final replacements = [6, 7];
        // numbers.replaceRange(1, 4, replacements);
        // print(numbers); // [1, 6, 7, 5]
        // alltime replace userId List
        chatNotifier.online
            .replaceRange(0, chatNotifier.online.length, [userId]);
      });
      // check user typing or not
      socket!.on('typing', (status) {
        // be careful typing(event) name same as backend otherwise get error
        chatNotifier.typingStatus = true; // change state for user typing
      });

      // check user typing stop
      socket!.on('stop typing', (status) {
        chatNotifier.typingStatus = false; // change state for user typing
      });

      // check user new message received
      socket!.on('new message', (newMessageReceived) {
        sendStopTypingEvent(widget.id);
        ReceivedMessages receivedMessages =
            ReceivedMessages.fromJson(newMessageReceived);

        if (receivedMessages.sender.id != chatNotifier.userId) {
          setState(() {
            // Inserts element at position index in this list.
            // This increases the length of the list by one and shifts all objects at or after the index towards the end of the list.
            // The list must be growable. The index value must be non-negative and no greater than length.
            // final numbers = <int>[1, 2, 3, 4];
            // const index = 2;
            // numbers.insert(index, 10);
            // print(numbers); // [1, 2, 10, 3, 4]
            // current received message all time 0 index er dike thakbe
            messages.insert(0, receivedMessages);
          });
        }
      });
    });
  }

  void sendMessage(String content, String chatId, String receiver) {
    SendMessage model =
        SendMessage(content: content, chatId: chatId, receiver: receiver);
    MessagingHelper.sendMessage(model).then((response) {
      // return [true, receivedMessage, responseMap];      --
      var emission = response[2]; // responseMap
      socket!.emit('new message', emission);
      sendStopTypingEvent(widget.id);
      setState(() {
        messageController.clear();
        messages.insert(0, response[1]); //receivedMessage--
      });
    });
  }

  void sendTypingEvent(String status) {
    socket!.emit('typing', status);
  }

  void sendStopTypingEvent(String status) {
    socket!.emit('stop typing', status);
  }

  void joinChat() {
    socket!.emit('join chat', widget.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessages(offset); // call get Message
    connect(); // socket connect call; which is useful for real time data update
    joinChat();
    handleNext(); // show 12 message per page and also scroll feature
  }

  @override
  Widget build(BuildContext context) {
    // device width and height
    final width = Get.width;
    final height = Get.height;
    return Consumer<ChatNotifier>(
        builder: (context, chatNotifier, child) {
      /*
          The first element that satisfies the given predicate test.
Iterates through elements and returns the first to satisfy test.

final numbers = <int>[1, 2, 3, 5, 6, 7];
var result = numbers.firstWhere((element) => element < 5); // 1
result = numbers.firstWhere((element) => element > 5); // 6
result =
    numbers.firstWhere((element) => element > 10, orElse: () => -1); // -1
           */
      // prothom theke check korbe je id userid er sathe equal hobe na seita return kore stop hoye jabe
      receiver = widget.user.firstWhere((id) => id != chatNotifier.userId);
      // print('receiver is: $receiver');
      // print('userId: ${chatNotifier.userId}');
      return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: CustomAppbar(
              text: !chatNotifier.typing ? widget.title: "typing....",
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
                            // online list er vitore all active user er list thakbe oitar vitor theke receiver er id thale active dekhabe(green)
                            backgroundColor: chatNotifier.online.contains(receiver) ?
                            Colors.green: Colors.grey,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          body: SafeArea(
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
                      final msgList = snapshot.data;
                      messages = messages + msgList!;
                      return ListView.builder(
                        // very useful for chat application
                        reverse: true, // if miss this message format like opposite
                        controller: _scrollController,
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final data = messages[index];

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
                )),
                // make sender send message box
                MessageTextField(
                  messageController: messageController,
                  suffixIcon: IconButton(
                      onPressed: () {
                        String msg = messageController.text;
                        // message send function call
                        sendMessage(msg, widget.id, receiver);
                      },
                      icon: Icon(
                        Icons.send,
                        size: 24,
                        color: Colors.lightBlue,
                      )),
                  onChanged: (_) {
                    sendTypingEvent(widget.id);
                  },
                  onEditingComplete: (){
                    String msg = messageController.text;
                    // message send function call
                    sendMessage(msg, widget.id, receiver);
                  },
                  onTapOutside: (_){
                    sendStopTypingEvent(widget.id);
                  },
                  onSubmitted: (_){
                    String msg = messageController.text;
                    sendMessage(msg, widget.id, receiver);
                  },
                )
              ],
            ),
          )));
    });
  }
}
/*
{

        },
 */
