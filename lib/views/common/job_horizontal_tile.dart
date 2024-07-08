import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';

class JobHorizontalTile extends StatelessWidget {
  final void Function()? onTap;

  const JobHorizontalTile({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          width: MediaQuery.of(context).size.width*0.7,
          height: MediaQuery.of(context).size.height*0.27,
          color: Colors.blueGrey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/facebook.png"),
                  ),
                  const SizedBox(width: 15,),
                  ReusableText(text: "FaceBook", style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 26
                  ))
                ],
              ),
              const SizedBox(height: 15,),
              ReusableText(text: "Senior Flutter Developer", style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20
              )),
              ReusableText(text: "Dhaka, BanglaDesh", style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 16
              )),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(

                    children: [
                  ReusableText(text: "40k", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 23,color: Colors.black)),
                  ReusableText(text: "/monthly", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 23,color: Colors.black)),

                    ],
                  ),
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.chevron_right_sharp),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
