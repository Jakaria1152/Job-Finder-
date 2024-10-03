import 'package:flutter/cupertino.dart';
import 'package:job_finder_app/model/response/job/jobs_response.dart';
import 'package:job_finder_app/services/authHelper/job_helper.dart';

class JobNotifier extends ChangeNotifier{
  late Future<List<JobsResponse>> jobList;
  late Future<JobsResponse> recent;

  getJobs(){
    jobList = JobHelper.getJobs(); // getJobs function static tai JobHelper() airokom kora lageni
  }

  getRecent(){
    recent = JobHelper.getRecentJobs();
  }

}