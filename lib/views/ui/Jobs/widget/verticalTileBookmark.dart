import 'package:flutter/material.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';

class VerticalTileBookMark extends StatelessWidget {
  final String job;
  final String user;
  final void Function()? onTap;
  const VerticalTileBookMark({super.key, this.onTap, required this.job, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        height: MediaQuery.of(context).size.height*0.18,
        width: double.infinity,
        color: Colors.blueGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(text: job.toString(), style: const TextStyle(
                        fontSize: 20,color: Colors.black, fontWeight: FontWeight.w600
                    )),
                    SizedBox(width: MediaQuery.of(context).size.width*0.5,
                      child:ReusableText(text: user.toString(), style: const TextStyle(
                          fontSize: 20,color: Colors.black, fontWeight: FontWeight.w600
                      )) ,)
                  ],
                ),
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.chevron_right),
                )
              ],
            ),


          ],
        ),
      ),
    );
  }
}
