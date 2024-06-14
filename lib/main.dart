import 'package:flutter/material.dart';
import 'package:job_finder_app/controllers/login_provider.dart';
import 'package:job_finder_app/views/ui/login_page.dart';
import 'package:provider/provider.dart';
void main(){
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => LoginNotifier(),)
    ],child: myApp(),)
  );
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
