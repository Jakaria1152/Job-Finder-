import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:job_finder_app/model/request/Message/send_message.dart';
import 'package:job_finder_app/model/response/Messaging/messaging_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class MessagingHelper{
// Send a message
  static Future<List<dynamic>> sendMessage(SendMessage model)async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    // String? userId = pref.getString('userId');

    http.Response? response;
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "x-auth-token": '$token'  // this is x-auth-token same as backend req.header("x-auth-token");
    };
    try{
      response = await http.post(
          Uri.parse('${Config.apiUrl}${Config.messagingUrl}'),
          headers: requestHeaders,
          body: model.toJson()
      )
      ;
    }catch(e)
    {
      print('BookMark Add api call error: $e');
    }

    if(response!.statusCode == 200)
    {
      ReceivedMessages receivedMessage = ReceivedMessages.fromJson(jsonDecode(response.body));
      //print('received message is: $receivedMessage');

      Map<String, dynamic> responseMap = jsonDecode(response.body);

      return [true, receivedMessage, responseMap];
    }
    else{
      return [false];
    }

  }

  // Get messages
  static Future<List<ReceivedMessages>> getMessages(String chatId, int offset)async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    // String? userId = pref.getString('userId');

    http.Response? response;
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "x-auth-token": '$token'  // this is x-auth-token same as backend req.header("x-auth-token");
    };
    try{
      response = await http.get(
          Uri.parse('${Config.apiUrl}${Config.messagingUrl}/$chatId'),
          headers: requestHeaders,
      )
      ;
    }catch(e)
    {
      print('BookMark Add api call error: $e');
    }

    if(response!.statusCode == 200)
    {
      List<ReceivedMessages> messages = receivedMessagesFromJson(response.body);

      return messages;

    }
    else{
      throw Exception('Failed load Message');
    }

  }
}