import 'package:flutter/material.dart';
import 'package:job_finder_app/model/response/job/jobs_response.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';

class JobHorizontalTile extends StatelessWidget {
  final void Function()? onTap;
  final JobsResponse? job;

  const JobHorizontalTile({super.key, this.onTap, required this.job});

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
                  CircleAvatar(
                    backgroundImage: NetworkImage(job!.imageUrl),
                  ),
                  const SizedBox(width: 15,),
                  ReusableText(text: job!.company, style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 26
                  ))
                ],
              ),
              const SizedBox(height: 15,),
              ReusableText(text: job!.title, style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20
              )),
              ReusableText(text: job!.location, style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 16
              )),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(

                    children: [
                  ReusableText(text: job!.salary, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 23,color: Colors.black)),
                  ReusableText(text: "/${job!.period}", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 23,color: Colors.black)),

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
