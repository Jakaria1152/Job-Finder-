import 'dart:convert';

import 'package:job_finder_app/model/response/Bookmark/all_bookmark.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../model/request/Bookmark/bookmark_request.dart';
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

    if(response!.statusCode == 201)
    {
      var body = jsonDecode(response.body);
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
  // GET BOOKMARK
  static Future<List<AllBookMarkRes>> getBookmarks()async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    String? userId = pref.getString('userId');

    http.Response? response;
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "x-auth-token": '$token'  // this is x-auth-token same as backend req.header("x-auth-token");
    };
    try{
      response = await http.get(
        Uri.parse('${Config.apiUrl}${Config.bookmarkUrl}/$userId'),
        headers: requestHeaders,
      )
      ;
    }catch(e)
    {
      print('BookMark Add api call error: $e');
    }
// print(response!.statusCode);
    if(response!.statusCode == 200)
    {
      // print(jsonDecode(response.body));
      List<AllBookMarkRes> bookmarkList = allBookMarkResFromJson(response.body);


     // print('bookmarkList is>>>>');

      // print(bookmarkList.length);
      // print(bookmarkList[0].job);


      return bookmarkList;
    }
    else{
      throw Exception('Failed to get bookmarks');
    }

  }
}