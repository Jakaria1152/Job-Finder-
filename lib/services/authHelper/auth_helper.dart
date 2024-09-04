import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:job_finder_app/model/request/LoginModel.dart';

import '../config.dart';
class AuthHelper{
static var client = https.Client();

// static Future<bool> login(LoginModel model)async{
//   Map<String, String> requestHeaders = {
//     "Content-Type": "application/json"
//   };
//
//   var url = Uri.https(Config.apiUrl, Config.loginUrl);
//   var response = await client.post(url,headers: requestHeaders, body: jsonEncode(model));
// }
}