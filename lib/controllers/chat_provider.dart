import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;  // very useful to calculate message time
import '../model/response/Chat/get_chat.dart';
import '../services/helper/chat_helper.dart';

class ChatNotifier extends ChangeNotifier{
late Future<List<GetChats>> chats;
List<String> _online = [];
List<String> get online => _online;
set onlineUsers(List<String> newList)
{
  _online = newList;
  notifyListeners();
}
String? userId;  // this id match chat users userId to find current user
getChats()
  {
   chats = Chathelper.getConversations();
  }

getPrefs()async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  userId = prefs.getString("userId");
}

// check user typing or not
  bool _typing = false;
bool get typing => _typing;
set typingStatus(bool newState)
{
  _typing = newState;
  notifyListeners();
}

// this function not calculate real time
  // String msgTime(String timestamp){
  //   DateTime now = DateTime.now();  // get current date Time
  //   DateTime messageTime = DateTime.parse(timestamp);  // covert string dateTime to DateTime Format
  //
  //   if(now.year == messageTime.year &&
  //   now.month == messageTime.month &&
  //   now.day == messageTime.day)
  //     {
  //       return DateFormat.Hm().format(messageTime);  // same date er message hole hour monutes e dekhabe
  //     }
  //   else if(now.year == messageTime.year &&
  //       now.month == messageTime.month &&
  //       now.day - messageTime.day == 1)  // today 17(now.day) - 16 = 1 **get yesterday
  //   {
  //       return "Yesterday";
  //   }
  //   else{
  //     return DateFormat.yMd().format(messageTime); // year month date format
  //   }
  // }

String showTimeAgo(String timeStamp) {
  DateTime messageTime = DateTime.parse(timeStamp);
  String timeAgo = timeago.format(messageTime);

  return timeAgo;
}
}