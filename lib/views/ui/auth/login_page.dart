import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/controllers/login_provider.dart';
import 'package:job_finder_app/model/request/LoginModel.dart';
import 'package:job_finder_app/views/common/app_bar.dart';
import 'package:job_finder_app/views/common/custom_button.dart';
import 'package:job_finder_app/views/common/custom_text_field.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';
import 'package:job_finder_app/views/ui/mainScreen.dart';
import 'package:job_finder_app/views/ui/auth/signUp_page.dart';
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
  void dispose() {  // dispose use for release memory
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(
      builder: (context, loginNotifier, child) {
        loginNotifier.getPrefs();
        // print(loginNotifier.loggedIn);
        return Scaffold(

          appBar: PreferredSize(preferredSize: const Size.fromHeight(50),
            child: CustomAppbar(text: 'Login',
              child: GestureDetector(
                  onTap: null,
                  child: Container()
                //const Icon(CupertinoIcons.arrow_left),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: loginNotifier.loginFormKey,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 50,),
                  ReusableText(text: 'Welcome Back!', style: const TextStyle(fontSize: 30,fontWeight: FontWeight.w600, color: Colors.black)),
                  ReusableText(text: 'Fill the details to login to your account', style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  )),
                  const SizedBox(height: 50,),
                  CustomTextField(controller: email,
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (email){
                      if(email!.isEmpty || !email.contains("@") )  // email filed jodi empty hoi and @ na thake tahole invalid message return korbe
                          {
                        return "Please enter a valid email";
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20,),
                  CustomTextField(controller: password,
                    hintText: "Password",
                    keyboardType: TextInputType.text,
                    validator: (password){
                      if(password!.isEmpty || password.length<7)  // email filed jodi empty hoi and @ na thake tahole invalid message return korbe
                          {
                        return "Please enter at least 6 digit password";
                      }
                      else{
                        return null;
                      }
                    },
                    obscureText: loginNotifier.obsecureText,
                    suffixIcon: GestureDetector(
                      onTap: (){
                        loginNotifier.obsecureText = !loginNotifier.obsecureText;
                      },
                      child:loginNotifier.obsecureText ? const Icon(Icons.visibility_off,color: Colors.black,) : const Icon(Icons.visibility,color: Colors.black,),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      // Get.offAll use koresi jeno login page ba signup age theke back korle onno page a na jai karon login, signup page e jawar jonno already button deya ase
                      onTap: ()=>Get.offAll(const signUpPage()),
                      child: ReusableText(text: "Register",style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                      ),),
                    ),
                  ),
                  const SizedBox(height: 50,),
                  CustomButton(text: 'Login',
                      onTap: (){

                          LoginModel model = LoginModel(
                              email: email.text,
                              password: password.text);

                          loginNotifier.userLogin(model);

                    // i get form (null) error so i comment out this code
                        if(loginNotifier.validateAndSave())
                        {
                          LoginModel model = LoginModel(
                              email: email.text,
                              password: password.text);
                          loginNotifier.userLogin(model);
                        }else{
                          Get.snackbar("Sign Failed", "Please check your credentials",
                              colorText: Colors.white,
                              backgroundColor: Colors.red,
                              icon: Icon(Icons.add_alert)
                          );
                        }
              // Get.to(MainScreen());
                      }
                  )

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
