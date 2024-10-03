import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:job_finder_app/model/response/job/jobs_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      print('api call error: $e');
    }

    if(response!.statusCode == 200)
    {
      var jobsList;
      print(jsonDecode(response.body));
      try{
        jobsList = jobsResponseFromJson(response.body);
      }catch(e)
      {
        print('error is $e');
      }

      return jobsList;
    }
    else{
      throw Exception('Failed to get JobsList');
    }

  }
}