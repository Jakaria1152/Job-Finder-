import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:get/get_core/src/get_main.dart';
import 'package:job_finder_app/model/request/signUpModel.dart';
import 'package:job_finder_app/services/authHelper/auth_helper.dart';
import 'package:job_finder_app/views/ui/auth/login_page.dart';

class SignUpNotifier extends ChangeNotifier{
  bool _obsecureText = true;

  bool get obsecureText => _obsecureText;

  set obsecureText(bool newState) {
    _obsecureText = newState;
    notifyListeners();  // for update state
  }

  // password validator check
bool passwordValidator(String password){
    if(password.isEmpty)
      return false;
    String pattern = r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)";

    RegExp regEx = RegExp(pattern);  // see details how it work
    return regEx.hasMatch(password);
}

// check form is valid or not (not empty field ensure)
  final registerFormKey = GlobalKey<FormState>();
  bool validateFormAndSave() {
    final form = registerFormKey.currentState;
print('registration validator called');
print(form);
print(form!.validate());
    if (form!.validate()) {
      form.save();
      print('form valid');
      return true;
    } else {
      print('form invalid');
      return false;
    }
  }

  // signUp logic
signUp(SignUpModel model)async{
AuthHelper.signUp(model).then((response){
  if(response)
    {

      // this is important and useful see carefully
      Get.off(()=>const LoginPage(),
      transition: Transition.fade,
        duration:const Duration(seconds: 2)
      );

    }else
      {

        Get.snackbar(
          "Sign up Failed",
          "Please Check your credentials and try again",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }
});
}

}