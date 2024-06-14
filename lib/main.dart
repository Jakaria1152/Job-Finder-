import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/controllers/login_provider.dart';
import 'package:job_finder_app/controllers/sign_up_notifier.dart';
import 'package:job_finder_app/views/ui/login_page.dart';
import 'package:provider/provider.dart';
void main(){
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => LoginNotifier(),),
      ChangeNotifierProvider(create: (context) => SignUpNotifier(),)
    ],child: myApp(),)
  );
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Job finder app',
      home: LoginPage(),
    );
  }
}
