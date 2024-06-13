import 'package:flutter/material.dart';
import 'package:job_finder_app/views/ui/login_page.dart';
void main(){
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Job finder app',
      home: LoginPage(),
    );
  }
}
