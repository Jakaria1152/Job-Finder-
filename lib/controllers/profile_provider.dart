import 'package:flutter/cupertino.dart';
import 'package:job_finder_app/model/response/auth/profile_response.dart';
import 'package:job_finder_app/services/helper/auth_helper.dart';

class ProfileNotifier extends ChangeNotifier{
  Future<ProfileResponse>? profile;
  getProfile()async{
   profile =  AuthHelper.getProfile();
  }
}