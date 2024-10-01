import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:job_finder_app/model/request/LoginModel.dart';
import 'package:job_finder_app/model/request/profile_update_model.dart';
import 'package:job_finder_app/model/request/signUpModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
class AuthHelper{
 //static var client = //https.Client();

  // login function
static Future<bool> login(LoginModel model)async{
  http.Response? response;



  Map<String, String> requestHeaders = {
    "Content-Type": "application/json"
  };
try{
  response = await http.post(Uri.parse('${Config.apiUrl}${Config.loginUrl}'),
      body: jsonEncode({
        // backend a send korte gele middlewar er jonno jsonEncode korte hoi
        "email": model.email,
        "password": model.password // "email", "password" same as req.body in backend otherwise get error
      }), // body ta jsonEncode kora hosse toJson() call kore
      headers: requestHeaders);
}catch(e)
  {
    print('login api call error: $e');
  }

  if(response!.statusCode == 200)
    {

      final SharedPreferences pref = await SharedPreferences.getInstance();
// print('res body is: ${response.body}');

//jsonDecode na korle aitar map value gulo access kora jai na
      //Converts the JSON string into a Dart map
var responseBody = jsonDecode(response.body);

      String token =responseBody['token'];
      String userId = responseBody['others']['_id'];
      String profile = responseBody['others']['profile'];

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

// SignUp function
  static Future<bool> signUp(SignUpModel model)async{
    http.Response? response;
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json"
    };
    try{
      response = await http.post(Uri.parse('${Config.apiUrl}${Config.signUpUrl}'),
         // body:  model.toJson() //// model er json ke call korsi aita automatically jsonEncode kore dibe json file ke
          body: model.toJson(),
          headers: requestHeaders);
    }catch(e)
    {
      print('login api call error: $e');
    }
// print(response?.statusCode);
    if(response!.statusCode == 201)
    {
      return true;
    }
    else{

      return false;
    }

  }

static Future<bool> updateProfile(ProfileUpdateModel model)async{
  final SharedPreferences pref = await SharedPreferences.getInstance();
  String? token = pref.getString("token");
  http.Response? response;



  Map<String, String> requestHeaders = {
    "Content-Type": "application/json",
    "x-auth-token": '$token'  // this is x-auth-token same as backend req.header("x-auth-token");
  };
  try{
    response = await http.put(Uri.parse('${Config.apiUrl}${Config.profileUrl}'),
        body: jsonEncode({
          // backend a send korte gele middlewar er jonno jsonEncode korte hoi
          "location": model.location,
          "phone": model.phone ,
          "profile": model.profile,
          "skills": model.skills
        }), // body ta jsonEncode kora hosse toJson() call kore
        headers: requestHeaders);
  }catch(e)
  {
    print('update profile api call error: $e');
  }

  if(response!.statusCode == 200)
  {
    print('response coed is: ${response.statusCode}');
    return true;
  }
  else{
    print('response coed is: ${response.statusCode}');
    return false;
  }

}
}