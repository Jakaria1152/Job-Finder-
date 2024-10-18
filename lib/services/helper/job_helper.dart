
import 'package:http/http.dart' as http;
import 'package:job_finder_app/model/response/job/jobs_response.dart';

import '../config.dart';

class JobHelper{
// Get Job
// Onek gulo job thakbe tai akta List er vitor e job job return kora hosse
  static Future<List<JobsResponse>> getJobs()async{
    http.Response? response;
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
    };
    try{
      response = await http.get(Uri.parse('${Config.apiUrl}${Config.jobs}'),
          headers: requestHeaders);
    }catch(e)
    {
      //print('api call error: $e');
    }

    if(response!.statusCode == 200)
    {
      List<JobsResponse> jobsList;
      // all time compare response data to model data. If any variable miss make it nullable
      // print(jsonDecode(response.body)); // this is helpful when not find proper error in response data

     // don't use try catch block here
        jobsList = jobsResponseFromJson(response.body);

      return jobsList;
    }
    else{
      throw Exception('Failed to get JobsList');
    }

  }

  // Get Recent Job
  static Future<JobsResponse> getRecentJobs()async{
    http.Response? response;
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
    };
    try{
      response = await http.get(Uri.parse('${Config.apiUrl}${Config.jobs}'),
          headers: requestHeaders);
    }catch(e)
    {
      //print('api call error: $e');
    }

    if(response!.statusCode == 200)
    {
      List<JobsResponse> jobsList;
      JobsResponse recent;

        jobsList = jobsResponseFromJson(response.body);
        // last insert kora job ta first a thakbe tai aitake recent er modde neya hosse
        recent = jobsList.first;


      return recent;
    }
    else{
      throw Exception('Failed to get Recent Job');
    }

  }

  // single job
  static Future<JobsResponse> getJob(String jobId)async{
    http.Response? response;
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
    };
    try{
      response = await http.get(Uri.parse('${Config.apiUrl}${Config.jobs}/$jobId'),
          headers: requestHeaders);
    }catch(e)
    {
      //print('api call error: $e');
    }

    if(response!.statusCode == 200)
    {
      // print(response.body.runtimeType);
      // use nullbale also return type nullable because its assign data on try block
      JobsResponse job; // make correct data type not use var or final
      // all time compare response data to model data. If any variable miss make it nullable
      // print(jsonDecode(response.body)); // this is helpful when not find proper error in response data

        job = singleJobResponseFromJson(response.body);
        // print(job.title);
        // print(job.salary);
        // print(job.location);

        // print(job.toStringFucntion());


      return job;
    }
    else{
      throw Exception('Failed to get a Job');
    }

  }

  // SEARCH JOB
  static Future<List<JobsResponse>> searchJobs(String searchQuery)async{
    http.Response? response;
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
    };

    try{
      response = await http.get(Uri.parse('${Config.apiUrl}${Config.search}/$searchQuery'),
          headers: requestHeaders);
    }catch(e)
    {
      //print('api call error: $e');
    }

    if(response!.statusCode == 200)
    {

      List<JobsResponse> jobsList;
      // all time compare response data to model data. If any variable miss make it nullable
      // print(jsonDecode(response.body)); // this is helpful when not find proper error in response data


        // here not use try catch block, if use get an error because flutter think jobsList is null
        jobsList = jobsResponseFromJson(response.body);


      return jobsList;
    }
    else{
      throw Exception('Failed to get JobsList');
    }

  }
}