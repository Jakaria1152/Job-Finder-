import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/controllers/job_provider.dart';
import 'package:job_finder_app/views/common/app_bar.dart';
import 'package:job_finder_app/views/common/drawer/drawerWidget.dart';
import 'package:job_finder_app/views/common/heading_widget.dart';
import 'package:job_finder_app/views/common/job_horizontal_tile.dart';
import 'package:job_finder_app/views/common/searchWidget.dart';
import 'package:job_finder_app/views/ui/Jobs/job_page.dart';
import 'package:job_finder_app/views/ui/search_page.dart';
import 'package:provider/provider.dart';

import '../common/VerticalTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppbar(
          actions: [
            Padding(
              padding: EdgeInsets.all(12),
              child: CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage("assets/images/profile.jpg"),
              ),
            )
          ],
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: DrawerWidget(),
          ),
        ),
      ),
      body: Consumer<JobNotifier>(
        builder: (context, jobNotifier, child) {
          // Firstly getAll Jobs
          jobNotifier.getJobs();
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Search\nFind & Apply',
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SearchWidget(
                    onTap: () {
                      Get.to( SearchPage());
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  HeadingWidget(
                    text: "Popular Jobs",
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    // height define kore na dile overflow error dibe. karon koto tuku height nibe ai builder bujhte pare na
                    height: MediaQuery.of(context).size.height * 0.28,
                    child: FutureBuilder(
                      // jobList take access kore neya hosse
                      future: jobNotifier.jobList,
                        builder: (context, snapshot) {
if(snapshot.connectionState == ConnectionState.waiting)
  {
    return Container();
  }
else if(snapshot.hasError)
  {
    return Center(child: Text('Error is: ${snapshot.error}'),);
  }
else{
final jobs = snapshot.data;
// be careful return otherwise not find what happend error. because not use return does not show any info
return ListView.builder(
  scrollDirection: Axis.horizontal,
  itemCount: jobs?.length,
  itemBuilder: (context, index) {
    final job = jobs?[index];
    return JobHorizontalTile(
job: job,
    onTap: () {
      Get.to(JobPage(title: job!.title,id: job.id,));
    },
  );
          }
);
}
                        },),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  HeadingWidget(
                    text: "Recently Posted",
                    onTap: () {},
                  ),
                  VerticalTile()
                ],
              ),
            ),
          ),
        );
      },),
    );
  }
}
