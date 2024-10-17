import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
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

  String msgTime(String timestamp){
    DateTime now = DateTime.now();  // get current date Time
    DateTime messageTime = DateTime.parse(timestamp);  // covert string dateTime to DateTime Format

    if(now.year == messageTime.year &&
    now.month == messageTime.month &&
    now.day == messageTime.day)
      {
        return DateFormat.Hm().format(messageTime);  // same date er message hole hour monutes e dekhabe
      }
    else if(now.year == messageTime.year &&
        now.month == messageTime.month &&
        now.day - messageTime.day == 1)  // today 17(now.day) - 16 = 1 **get yesterday
    {
        return "Yesterday";
    }
    else{
      return DateFormat.yMd().format(messageTime); // year month date format
    }



  }
}