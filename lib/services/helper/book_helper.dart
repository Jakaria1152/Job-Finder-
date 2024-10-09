import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../model/request/Bookmark/bookmark_request.dart';
import '../../model/response/Bookmark/bookmark.dart';
import '../config.dart';
class BookMarkHelper{
  // ADD BOOKMARK
  static Future<List<dynamic>> addBookmarks(BookmarkRequest model)async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    String? userId = pref.getString('userId');

    http.Response? response;
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "x-auth-token": '$token'  // this is x-auth-token same as backend req.header("x-auth-token");
    };
    try{
      response = await http.post(
          Uri.parse('${Config.apiUrl}${Config.bookmarkUrl}/$userId'),
          headers: requestHeaders,
      body: jsonEncode(model.toJson()))
      ;
    }catch(e)
    {
      print('BookMark Add api call error: $e');
    }

    if(response!.statusCode == 200)
    {
      var body = jsonDecode(response!.body);
      String bookMarkId = body['_id'];

      // print(bookMarkId);
      return [true,bookMarkId];
    }
    else{
      return [false];
    }

  }

  // DELETE BOOKMARK
  static Future<bool> deleteBookmarks(String jobId)async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    // String? userId = pref.getString('userId');

    http.Response? response;
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "x-auth-token": '$token'  // this is x-auth-token same as backend req.header("x-auth-token");
    };
    try{
      response = await http.delete(
          Uri.parse('${Config.apiUrl}${Config.bookmarkUrl}/$jobId'),
          headers: requestHeaders,
      )
      ;
    }catch(e)
    {
      print('BookMark Add api call error: $e');
    }

    if(response!.statusCode == 200)
    {
      // print("delete");
      return true;
    }
    else{
      return false;
    }

  }
}