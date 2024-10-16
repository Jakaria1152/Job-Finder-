import 'package:flutter/cupertino.dart';

import '../model/response/Chat/get_chat.dart';
import '../services/helper/chat_helper.dart';

class ChatNotifier extends ChangeNotifier{
late Future<List<GetChats>> chats;
getChats()
  {
   chats = Chathelper.getConversations();
  }
}