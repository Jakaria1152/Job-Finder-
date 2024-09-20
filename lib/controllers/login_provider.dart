import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/services/authHelper/auth_helper.dart';
import 'package:job_finder_app/views/ui/mainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/request/LoginModel.dart';

class LoginNotifier extends ChangeNotifier{
  bool _obsecureText = true;

  bool get obsecureText => _obsecureText;

  set obsecureText(bool newState) {
    _obsecureText = newState;
    notifyListeners();  // for update state
  }

  bool? _loggedIn;

  bool get loggedIn => _loggedIn??false; // null thake false return korbe

  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();  // for update state
  }

  getPrefs()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedIn = prefs.getBool('loggedIn')??false;
    //entrypoint = prefs.getBool('entrypoint')??false;
  }
  final loginFormKey = GlobalKey<FormState>();

  bool validateAndSave()
  {
    final form = loginFormKey.currentState;

    if(form!.validate())
      {
        form.save();
        return true;
      }
    else{
      return false;
    }
  }

  userLogin(LoginModel model)
  {
        AuthHelper.login(model).then((response){
          if(response)
            {
              Get.off(MainScreen());
            }
          else if(!response){
            Get.snackbar("Sign Failed", "Please check your credentials",
            colorText: Colors.white,
              backgroundColor: Colors.red,
              icon: Icon(Icons.add_alert)
            );
          }
        });
  }

  // logout hole cache memory theke token remove hoye jabe
  logout()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.setBool('loggedIn', false);
  }
}