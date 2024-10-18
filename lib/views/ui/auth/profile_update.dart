import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/controllers/login_provider.dart';
import 'package:job_finder_app/views/common/app_bar.dart';
import 'package:provider/provider.dart';

import '../../../controllers/image_provider.dart';
import '../../../model/request/profile_update_model.dart';
import '../../../model/response/auth/profile_response.dart';
import '../../common/custom_button.dart';
import '../../common/custom_text_field.dart';
import '../../common/reusable_text.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({super.key, required this.profile});
final ProfileResponse profile;
  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController skill0 = TextEditingController();
  TextEditingController skill1 = TextEditingController();
  TextEditingController skill2 = TextEditingController();
  TextEditingController skill3 = TextEditingController();
  TextEditingController skill4 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phone.text = widget.profile.phone!;
    location.text = widget.profile.location;
    skill0.text = widget.profile.skills[0];
    skill1.text = widget.profile.skills[1];
    skill2.text = widget.profile.skills[2];
    skill3.text = widget.profile.skills[3];
    skill4.text = widget.profile.skills[4];
  }
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
    final imageUploader = Provider.of<ImageUploader>(context,listen: true);
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50),
          child: CustomAppbar(
              text: 'Update Profile',
              child: GestureDetector(
            onTap: (){
Get.back();
            },
            child: const Icon(CupertinoIcons.arrow_left),
          ))),
      body: Consumer<LoginNotifier>(
        builder: (BuildContext context, loginNotifier, Widget? child) {
          return Form(
            key: loginNotifier.profileFormKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 60),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ReusableText(text: 'Personal Details', style: TextStyle(fontSize: 35,
                        color: Colors.black, fontWeight: FontWeight.bold)),

                    // image upload na thakle empty hobe tai image pick korbe
                    imageUploader.imageFil.isEmpty? GestureDetector(
                      onTap: (){
                        // image gallery open hobe
                        imageUploader.pickImage();
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.lightBlue,
                        //backgroundImage: ,
                        child: Icon(Icons.photo_filter_rounded),
                      ),
                    ):
                    GestureDetector(
                      onTap: (){
                        // image list ta clear hoye jasse
                        imageUploader.imageFil.clear();
                        setState(() {

                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.lightBlue,
                        // selected image ta show korbe
                        backgroundImage: FileImage(File(imageUploader.imageFil[0])),

                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Form(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(controller: location, hintText: 'Location', keyboardType: TextInputType.text,
                      validator: (location) {
                        if(location!.isEmpty)
                        {
                          return "Please Enter valid location";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10,),
                    CustomTextField(controller: phone, hintText: 'Phone', keyboardType: TextInputType.number,
                      validator: (phone) {
                        if(phone!.isEmpty)
                        {
                          return "Please Enter valid phone";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10,),
                    const ReusableText(text: 'Professional Skills', style: TextStyle(fontSize: 35,
                        color: Colors.black, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10,),
                    CustomTextField(controller: skill0, hintText: 'Professional Skills', keyboardType: TextInputType.text,
                      validator: (skill0) {
                        if(skill0!.isEmpty)
                        {
                          return "Please Enter valid professional skill";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10,),
                    CustomTextField(controller: skill1, hintText: 'Professional Skills', keyboardType: TextInputType.text,
                      validator: (skill1) {
                        if(skill1!.isEmpty)
                        {
                          return "Please Enter valid professional skill";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10,),
                    CustomTextField(controller: skill2, hintText: 'Professional Skills', keyboardType: TextInputType.text,
                      validator: (skill2) {
                        if(skill2!.isEmpty)
                        {
                          return "Please Enter valid professional skill";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10,),
                    CustomTextField(controller: skill3, hintText: 'Professional Skills', keyboardType: TextInputType.text,
                      validator: (skill3) {
                        if(skill3!.isEmpty)
                        {
                          return "Please Enter valid professional skill";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10,),
                    CustomTextField(controller: skill4, hintText: 'Professional Skills', keyboardType: TextInputType.text,
                      validator: (skill4) {
                        if(skill4!.isEmpty)
                        {
                          return "Please Enter valid professional skill";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20,),
                    Consumer<ImageUploader>(builder: (context, imageUploader, child) {
                      return CustomButton(onTap: (){
                        if(imageUploader.imageFil.isEmpty && imageUploader.imageUrl == null)
                        {
                          Get.snackbar("Image Missing", "Please upload an image to proceed",
                              colorText: Colors.white,
                              backgroundColor: Colors.orange,
                              icon: const Icon(Icons.add_alert)
                          );
                        }else
                        {
                          if(loginNotifier.profileValidation())
                          {
                            ProfileUpdateModel model = ProfileUpdateModel(
                                location: location.text,
                                phone: phone.text,
                                profile: imageUploader.imageUrl??"",
                                skills: [skill0.text,skill1.text,skill2.text,skill3.text,skill4.text]
                            );

                            // call update profile function
                            loginNotifier.updateProfile(model);
                          }
                        }
                      },text: 'Update Profile');
                    },)
                  ],
                ))
              ],
            ),
          );
        },

      )
    );
  }
}
