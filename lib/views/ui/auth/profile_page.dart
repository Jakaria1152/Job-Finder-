import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/controllers/profile_provider.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';
import 'package:job_finder_app/views/ui/auth/profile_update.dart';
import 'package:provider/provider.dart';

import '../../common/app_bar.dart';
import '../../common/drawer/drawerWidget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppbar(
          text: 'Profile',
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: DrawerWidget(),
          ),
        ),
      ),
      body: Consumer<ProfileNotifier>(builder:
          (context, profileNotifier, child) {
        profileNotifier.getProfile();
      return FutureBuilder(
        future: profileNotifier.profile,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          else if(snapshot.hasError)
            {
              return Center(
                child: Text('Error ${snapshot.error}'),
              );
            }
          else{
            final userData = snapshot.data;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.12,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          child: Image.network(
                            userData!.profile,
                            width: 80,
                            height: 100,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReusableText(
                                text: userData.username,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600)),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_pin,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                ReusableText(
                                    text: userData.location,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ],
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(ProfileUpdate(profile: userData,));
                          },
                          child: const Icon(
                            Icons.edit_calendar_outlined,
                            size: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      Container(
                        color: Colors.grey.withOpacity(0.3),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 12),
                              width: 60,
                              height: 70,
                              color: Colors.white,
                              child: const Icon(
                                FontAwesomeIcons.filePdf,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ReusableText(
                                    text: "Resume from JobHub",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500)),
                                ReusableText(
                                    text: "JobHub Resume",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                            const SizedBox(
                              width: 1,
                            ) // when use this text get to the center
                          ],
                        ),
                      ),
                      Positioned(
                          top: 2,
                          right: 5,
                          child: GestureDetector(
                            onTap: () {},
                            child: const ReusableText(
                              text: "Edit",
                              style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.06,
                    color: Colors.grey.withOpacity(0.3),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ReusableText(text: userData.email,style: const TextStyle(
                          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600
                      ),),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.06,
                    color: Colors.grey.withOpacity(0.3),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/icon/Flag_of_Bangladesh.svg",height: 20,width: 20,),
                          const SizedBox(width: 15,),
                          ReusableText(text: userData.phone??"",style: const TextStyle(
                              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600
                          ),),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    color: Colors.grey.withOpacity(0.3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ReusableText(text: 'Skills', style: TextStyle(
                              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600
                          )),
                        ),
                        const SizedBox(height: 3,),
                        SizedBox(height: MediaQuery.of(context).size.height*0.35,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: userData.skills.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height*0.06,
                                    color: Colors.white,
                                    child: ReusableText(text:userData.skills[index],style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        fontSize: 16
                                    ),),
                                  ),
                                );
                              },),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },

      );
      },),
    );
  }
}
