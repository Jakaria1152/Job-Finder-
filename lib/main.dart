import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/views/ui/auth/login_page.dart';
import 'package:job_finder_app/controllers/exports.dart';  // this is use very reduce large amount import
import 'package:job_finder_app/views/ui/mainScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/signup_provider.dart';
import 'firebase_options.dart';


//Widget defaultHome = const OnboardingScreen(); this is use for knowledge
Widget defaultHome = const LoginPage();
void main()async{
  WidgetsFlutterBinding.ensureInitialized(); //used to ensure that the Flutter engine's bindings are properly set up before your application starts to run tasks, like initializing services or plugins
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final SharedPreferences prefs = await SharedPreferences.getInstance();
 // final entrypoint = prefs.getBool('entrypoint')??false;  // this is useful when use onBoarding Screen
  final loggedIn = prefs.getBool('loggedIn')??false;
  if(loggedIn)
    {
      defaultHome = const MainScreen(); // local storage e loggedIn true thakle bar bar app open korar somoi login screen show korbe na. MainScreen a cole jabe
    }
  else{
    defaultHome = const LoginPage();
  }
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => LoginNotifier(),),
      ChangeNotifierProvider(create: (context) => SignUpNotifier(),),
      ChangeNotifierProvider(create: (context) => ZoomNotifier(),),
      ChangeNotifierProvider(create: (context) => ImageUploader(),),
      ChangeNotifierProvider(create: (context) => ProfileNotifier(),),
      ChangeNotifierProvider(create: (context) => JobNotifier(),),
      ChangeNotifierProvider(create: (context) => BookMarkNotifier(),),
      ChangeNotifierProvider(create: (context) => ChatNotifier(),),
    ],child: const myApp(),)
  );
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Job finder app',
      home: defaultHome,
      //home: defaultHome,  // condition er upor base kore login or main page show korbe
    );
  }
}
