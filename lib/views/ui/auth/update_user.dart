import 'package:flutter/material.dart';
import 'package:job_finder_app/controllers/login_provider.dart';
import 'package:job_finder_app/controllers/zoom_notifier.dart';
import 'package:job_finder_app/views/common/custom_button.dart';
import 'package:job_finder_app/views/common/custom_text_field.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';
import 'package:provider/provider.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController skill0 = TextEditingController();
  TextEditingController skill1 = TextEditingController();
  TextEditingController skill2 = TextEditingController();
  TextEditingController skill3 = TextEditingController();
  TextEditingController skill4 = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phone.dispose();
    location.dispose();
    skill0.dispose();
    skill1.dispose();
    skill2.dispose();
    skill3.dispose();
    skill4.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Consumer<LoginNotifier>(  // LoginNotifier which is provider file(must same this name)
        builder: (context, loginNotifier, child) {  // loginNotifier use any name here
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 60),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
ReusableText(text: 'Personal Details', style: TextStyle(fontSize: 35,
color: Colors.black, fontWeight: FontWeight.bold)),
                
                GestureDetector(
                  onTap: null,
                  child: CircleAvatar(
                    backgroundColor: Colors.lightBlue,
                    //backgroundImage: ,
                    child: Icon(Icons.photo_filter_rounded),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
Form(child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    CustomTextField(controller: location, hintText: 'Location', keyboardType: TextInputType.text,
    validator: (location) {
      if(location!.isEmpty)
        {
          return "Please Enter valid location";
        }
      else{
        return null!;
      }
    },
    ),
    SizedBox(height: 10,),
    CustomTextField(controller: phone, hintText: 'Phone', keyboardType: TextInputType.number,
    validator: (phone) {
      if(phone!.isEmpty)
        {
          return "Please Enter valid phone";
        }
      else{
        return null!;
      }
    },
    ),
    SizedBox(height: 10,),
    ReusableText(text: 'Professional Skills', style: TextStyle(fontSize: 35,
        color: Colors.black, fontWeight: FontWeight.bold)),
    SizedBox(height: 10,),
    CustomTextField(controller: skill0, hintText: 'Professional Skills', keyboardType: TextInputType.text,
      validator: (skill0) {
        if(skill0!.isEmpty)
        {
          return "Please Enter valid professional skill";
        }
        else{
          return null!;
        }
      },
    ),
    SizedBox(height: 10,),
    CustomTextField(controller: skill1, hintText: 'Professional Skills', keyboardType: TextInputType.text,
      validator: (skill1) {
        if(skill1!.isEmpty)
        {
          return "Please Enter valid professional skill";
        }
        else{
          return null!;
        }
      },
    ),
    SizedBox(height: 10,),
    CustomTextField(controller: skill2, hintText: 'Professional Skills', keyboardType: TextInputType.text,
      validator: (skill2) {
        if(skill2!.isEmpty)
        {
          return "Please Enter valid professional skill";
        }
        else{
          return null!;
        }
      },
    ),
    SizedBox(height: 10,),
    CustomTextField(controller: skill3, hintText: 'Professional Skills', keyboardType: TextInputType.text,
      validator: (skill3) {
        if(skill3!.isEmpty)
        {
          return "Please Enter valid professional skill";
        }
        else{
          return null!;
        }
      },
    ),
    SizedBox(height: 10,),
    CustomTextField(controller: skill4, hintText: 'Professional Skills', keyboardType: TextInputType.text,
      validator: (skill4) {
        if(skill4!.isEmpty)
        {
          return "Please Enter valid professional skill";
        }
        else{
          return null!;
        }
      },
    ),
    SizedBox(height: 20,),
    CustomButton(onTap: (){

    },text: 'Update Profile')
  ],
))
          ],
        );
      },)
    );
  }
}
