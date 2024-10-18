import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/model/response/job/jobs_response.dart';
import 'package:job_finder_app/views/common/VerticalTile.dart';
import 'package:job_finder_app/views/ui/Jobs/job_page.dart';
import 'package:job_finder_app/views/ui/widget/customField.dart';

import '../../../services/helper/job_helper.dart';
import '../../common/search_loader.dart';

class SearchPage extends StatefulWidget {

  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  backgroundColor: Colors.deepOrange,
  iconTheme: const IconThemeData(color: Colors.white),  // all item color white kore dibe
  title: CustomField(
    search: search,
    hintText: "Search for a Job",
  suffixIcon: GestureDetector(
    onTap: (){
setState(() {

});
    },
    child: const Icon(Icons.search,size: 25,color: Colors.white,),
  ),
  ),
  elevation: 0,
),
      body: search.text.isNotEmpty ?
          FutureBuilder<List<JobsResponse>>(
            future: JobHelper.searchJobs(search.text),
            builder: (context, snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(),);
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error is: ${snapshot.error}'),
                );
              }
              else if(snapshot.data!.isEmpty)
                {
                  return const SearchLoading(text: 'Job Not Found');
                }
              else{
                final jobs = snapshot.data;
                return ListView.builder(
                  itemCount: jobs?.length,
                  itemBuilder: (context, index) {
                  final job = jobs?[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: GestureDetector(
                        onTap: (){
                          Get.to(JobPage(
                              title: job.title,
                              id: job.id));
                        },
                        child: VerticalTile(job: job!)),
                  ); // if show error use ! null check
                },);
              }
          },)
          : const Center(
        child: SearchLoading(text: 'Start Searching for Jobs',),
      ),
    );
  }
}




