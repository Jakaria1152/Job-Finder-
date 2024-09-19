import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:job_finder_app/model/request/LoginModel.dart';
import 'package:job_finder_app/model/response/auth/login%20response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
class AuthHelper{
static var client = https.Client();

static Future<bool> login(LoginModel model)async{
  Map<String, String> requestHeaders = {
    "Content-Type": "application/json"
  };

  var url = Uri.https(Config.apiUrl, Config.loginUrl);
  var response = await client.post(url,headers: requestHeaders, body: jsonEncode(model));

  if(response.statusCode == 200)
    {
      final SharedPreferences pref = await SharedPreferences.getInstance();

      String token = loginResponseModelFromJson(response.body).token;
      String userId = loginResponseModelFromJson(response.body).id;
      String profile = loginResponseModelFromJson(response.body).profile;

      await pref.setString('token', token);
      await pref.setString('userId', userId);
      await pref.setString('profile', profile);
      await pref.setBool('loggedIn', true);  // bar bar login screen show korbena aitar karone


      return true;
    }
  else{
    return false;
  }

}
}