import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/response/Chat/get_chat.dart';
import '../services/helper/chat_helper.dart';

class ChatNotifier extends ChangeNotifier{
late Future<List<GetChats>> chats;
String? userId;  // this id match chat users userId to find current user
getChats()
  {
   chats = Chathelper.getConversations();
  }

getPrefs()async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  userId = prefs.getString("userId");
}
}