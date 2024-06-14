import 'package:flutter/material.dart';
import 'package:job_finder_app/controllers/login_provider.dart';
import 'package:job_finder_app/views/common/app_bar.dart';
import 'package:job_finder_app/views/common/custom_button.dart';
import 'package:job_finder_app/views/common/custom_text_field.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';
import 'package:provider/provider.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {  // dispose for release memory
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(
      builder: (context, loginNotifier, child) {
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
                CustomTextField(controller: email,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (email){
                    if(email!.isEmpty || !email.contains("@") )  // email filed jodi empty hoi and @ na thake tahole invalid message return korbe
                        {
                      return "Please enter a valid email";
                    }
                    else{
                      return null!;
                    }
                  },
                ),
                SizedBox(height: 20,),
                CustomTextField(controller: password,
                  hintText: "Password",
                  keyboardType: TextInputType.text,
                  validator: (password){
                    if(password!.isEmpty || password.length<7)  // email filed jodi empty hoi and @ na thake tahole invalid message return korbe
                        {
                      return "Please enter at least 6 digit pasword";
                    }
                    else{
                      return null!;
                    }
                  },
                  obscureText: loginNotifier.obsecureText,
                  suffixIcon: GestureDetector(
                    onTap: (){
                      loginNotifier.obsecureText = !loginNotifier.obsecureText;
                    },
                    child: Icon(Icons.visibility,color: Colors.black,),
                  ),
                ),
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: null,
                    child: ReusableText(text: "Register",style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    ),),
                  ),
                ),
                SizedBox(height: 50,),
                CustomButton(text: 'Login',
                    onTap: (){

                    }
                )

              ],
            ),
          ),
        );
      },
    );
  }
}
