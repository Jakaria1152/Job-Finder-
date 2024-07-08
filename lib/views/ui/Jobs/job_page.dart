import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/constants/constant.dart';
import 'package:job_finder_app/views/common/app_bar.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';

class JobPage extends StatefulWidget {
  final String title;
  final String id;
  const JobPage({super.key, required this.title, required this.id});

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50),
      child: CustomAppbar(
        text: widget.title,
        child: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: const Icon(CupertinoIcons.arrow_left),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.bookmark),
          )
        ],
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 30,),
                Container(
                  height: MediaQuery.of(context).size.height*0.27,
                  width: double.infinity,
                  color: Colors.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage("assets/images/profile.jpg"),
                      ),
                      const SizedBox(height: 10,),
                      ReusableText(text: "Senior Flutter Developer", style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w600
                      )),
                      const SizedBox(height: 5,),
                      ReusableText(text: "New York", style: const TextStyle(
                          fontSize: 22,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.normal
                      )),
                      const SizedBox(height: 15,),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(style: OutlinedButton.styleFrom(backgroundColor: Colors.white,
                          foregroundColor: Colors.deepOrange,
                            
                          ),onPressed: (){}, child: const Text('Full-Time')),
                          
                          Row(
                            children: [
                              ReusableText(text: "30k", style: const TextStyle(fontSize: 22,color: Colors.black,fontWeight: FontWeight.w600)),
                              ReusableText(text: "/monthly", style: const TextStyle(fontSize: 22,color: Colors.black,fontWeight: FontWeight.w600)),
                            ],
                          )
                        ],
                      ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                ReusableText(text: "Job description", style: const TextStyle(fontSize: 22,color: Colors.black, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10,),
                const Text("A Flutter Developer specializes in utilizing the Flutter framework to create cross-platform mobile applications for both Android and iOS platforms. Flutter developer uses the Dart programming language to build visually appealing and functional user interfaces, ensuring a consistent user experience across various devices. Flutter Developers are responsible for the entire app development lifecycle, from concept and design to coding, testing, and integration of external services.App development, UI/UX implementation, code debugging, performance optimization, and the integration of APIs are key responsibilities and roles of Flutter Developers. They have proficiency in Dart programming, UI/UX design, state management, API integration, testing, debugging, and version control. Flutter Developers excel in cross-platform development, maximizing code reusability.",
                textAlign: TextAlign.justify,
                  maxLines: 8,
                  style: TextStyle(
                    fontSize: 16, color: Colors.grey, fontWeight: FontWeight.normal
                  ),
                ),
                const SizedBox(height: 20,),
                ReusableText(text: "Requirements", style: const TextStyle(fontSize: 22,color: Colors.black, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10,),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.6,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: requirement.length,
                    itemBuilder: (context, index) {
                      final req = requirement[index];
                      String bullet = "\u2022 ";

                      return Text('$bullet $req\n',maxLines: 4,
                      textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold
                        ),
                      );

                  },),
                )
              ],

            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: OutlinedButton(style: OutlinedButton.styleFrom(backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white
              ),
                onPressed: ()
                {

                },
                child: Text('Apply Now'),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
