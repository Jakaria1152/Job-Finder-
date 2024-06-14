import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/views/common/app_bar.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

appBar: PreferredSize(preferredSize: Size.fromHeight(50),
child: CustomAppbar(text: 'Login',
child: GestureDetector(
  onTap: null,
  child: Container()
  //const Icon(CupertinoIcons.arrow_left),
),
),
),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
SizedBox(height: 50,),
            ReusableText(text: 'Welcome Back!', style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600, color: Colors.black)),
            ReusableText(text: 'Fill the details to login to your account', style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w600
            )),
            SizedBox(height: 50,),

          ],
        ),
      ),
    );
  }
}
