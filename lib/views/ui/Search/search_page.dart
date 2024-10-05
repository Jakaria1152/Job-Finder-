import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/model/response/job/jobs_response.dart';
import 'package:job_finder_app/services/authHelper/job_helper.dart';
import 'package:job_finder_app/views/common/VerticalTile.dart';
import 'package:job_finder_app/views/common/custom_text_field.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';
import 'package:job_finder_app/views/ui/Jobs/job_page.dart';
import 'package:job_finder_app/views/ui/widget/customField.dart';

class SearchPage extends StatefulWidget {

  SearchPage({super.key});

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
  iconTheme: IconThemeData(color: Colors.white),  // all item color white kore dibe
  title: CustomField(
    search: search,
    hintText: "Search for a Job",
  suffixIcon: GestureDetector(
    onTap: (){
setState(() {

});
    },
    child: Icon(Icons.search,size: 25,color: Colors.white,),
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
                return Center(child: CircularProgressIndicator(),);
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
          : Center(
        child: const SearchLoading(text: 'Start Searching for Jobs',),
      ),
    );
  }
}

class SearchLoading extends StatelessWidget {
  final String text;
  const SearchLoading({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/icon/optimized search.jpg', fit: BoxFit.cover,),
          ReusableText(text: text, style: TextStyle(
            fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold
          ))
        ],
      ),
    );
  }
}


