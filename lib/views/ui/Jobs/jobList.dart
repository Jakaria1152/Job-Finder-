import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/controllers/job_provider.dart';
import 'package:job_finder_app/views/common/VerticalTile.dart';
import 'package:provider/provider.dart';

import '../../common/app_bar.dart';
import 'job_page.dart';

class JoblistPage extends StatelessWidget {
  const JoblistPage({super.key});

  @override
  Widget build(BuildContext context) {
    var jobList = Provider.of<JobNotifier>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppbar(
          text: "Jobs",
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(CupertinoIcons.arrow_left),
          ),
        ),
      ),
      body: FutureBuilder(
        // already getJob call and get jobs from backend so not need again call only access jobList
        future: jobList.jobList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error is: ${snapshot.error}'),
            );
          } else {
            // snapshot data ke job variable er vitore neya hosse
            final jobs = snapshot.data;
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: jobs?.length, // requirement length
              itemBuilder: (context, index) {
                final job = jobs?[index];  // single requirement
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 7),
                  child: GestureDetector(
                      onTap: (){
                        Get.to(
                            JobPage(
                          title: job.title,
                          id: job.id,
                        ));
                      },
                      child: VerticalTile(job: job!)),
                );
              },
            );
          }
        },
      ),
    );
  }
}
