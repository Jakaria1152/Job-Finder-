import 'package:flutter/material.dart';
import 'package:job_finder_app/model/response/job/jobs_response.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';

class VerticalTile extends StatelessWidget {
  final JobsResponse job;
  final void Function()? onTap;
  const VerticalTile({super.key, this.onTap, required this.job});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        height: MediaQuery.of(context).size.height*0.15,
        width: double.infinity,
        color: Colors.blueGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(job.imageUrl),
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(text: job.company, style: TextStyle(
                      fontSize: 20,color: Colors.black, fontWeight: FontWeight.w600
                    )),
                    SizedBox(width: MediaQuery.of(context).size.width*0.5,
                    child:ReusableText(text: job.title, style: TextStyle(
                        fontSize: 20,color: Colors.black, fontWeight: FontWeight.w600
                    )) ,)
                  ],
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.chevron_right),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                children: [
                  ReusableText(text: job.salary, style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.w600
                  )),
                  ReusableText(text: "/monthly", style: TextStyle(
                      color: Colors.grey,
                      fontSize: 23,
                      fontWeight: FontWeight.w600
                  ))
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
