import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/controllers/login_provider.dart';
import 'package:job_finder_app/model/request/signUpModel.dart';
import 'package:job_finder_app/views/ui/auth/login_page.dart';
import 'package:provider/provider.dart';
import '../../../controllers/signup_provider.dart';
import '../../common/app_bar.dart';
import '../../common/custom_button.dart';
import '../../common/custom_text_field.dart';
import '../../common/reusable_text.dart';

class signUpPage extends StatefulWidget {
  const signUpPage({super.key});

  @override
  State<signUpPage> createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    name.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Consumer<SignUpNotifier>(
      builder: (context, signUpNotifier, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppbar(
              text: 'Sign Up',
              child: GestureDetector(onTap: null, child: Container()
                  //const Icon(CupertinoIcons.arrow_left),
                  ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: signUpNotifier.registerFormKey,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const ReusableText(
                      text: 'Hello, Welcome!',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                  const ReusableText(
                      text: 'Fill the details to signup to your account',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextField(
                    controller: name,
                    hintText: "Full Name",
                    keyboardType: TextInputType.text,
                    validator: (name) {
                      if (name!
                          .isEmpty) // email filed jodi empty hoi and @ na thake tahole invalid message return korbe
                      {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: email,
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email!.isEmpty ||
                          !email.contains(
                              "@")) // email filed jodi empty hoi and @ na thake tahole invalid message return korbe
                      {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: password,
                    hintText: "Password",
                    keyboardType: TextInputType.text,
                    validator: (password) {
                      if (password!.isEmpty ||
                          password.length <
                              6) // email filed jodi empty hoi and @ na thake tahole invalid message return korbe
                      {
                        return "Please enter at least 6 digit password";
                      }
                      return null;
                    },
                    obscureText: signUpNotifier.obsecureText,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        signUpNotifier.obsecureText =
                            !signUpNotifier.obsecureText;
                      },
                      child: signUpNotifier.obsecureText
                          ? const Icon(
                              Icons.visibility_off,
                              color: Colors.black,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: Colors.black,
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      // Get.offAll use koresi jeno login page ba signup age theke back korle onno page a na jai karon login, signup page e jawar jonno already button deya ase
                      onTap: () => Get.offAll(const LoginPage()),
                      child: const ReusableText(
                        text: "Login",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomButton(
                      text: 'Sign Up',
                      onTap: () {
                        // user registration complete korle first time false kore deya hobe jeno next time login korte gele profile update page show na kore
                        loginNotifier.firstTime = !loginNotifier.firstTime;

                        if (signUpNotifier.validateFormAndSave()) {
                          SignUpModel model = SignUpModel(
                              email: email.text,
                              password: password.text,
                              username: name.text);

                          signUpNotifier.signUp(model);
                        } else {
                          Get.snackbar(
                            "Sign up Failed",
                            "Please fill this field",
                            colorText: Colors.white,
                            backgroundColor: Colors.red,
                            icon: const Icon(Icons.add_alert),
                          );
                        }
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
