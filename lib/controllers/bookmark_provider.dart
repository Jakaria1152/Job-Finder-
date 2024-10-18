import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/model/request/Bookmark/bookmark_request.dart';
import 'package:job_finder_app/model/response/Bookmark/all_bookmark.dart';
import 'package:job_finder_app/services/helper/book_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMarkNotifier extends ChangeNotifier{
  Future<List<AllBookMarkRes>>? bookmarks;
  List<String> _jobs = [];
  List<String> get jobs => _jobs;
  set jobs(List<String> newList){
    _jobs = newList;
    notifyListeners();
  }
  Future<void> addJob(String jobId)async{
    final prefs = await SharedPreferences.getInstance();
      _jobs.insert(0, jobId);
      prefs.setStringList("jobId", _jobs);
      notifyListeners();
      }

  Future<void> removeJob(String jobId)async{
    final prefs = await SharedPreferences.getInstance();
    _jobs.remove(jobId);
    prefs.setStringList("jobId", _jobs);
    notifyListeners();
    }

  Future<void> loadJobs()async{
    final prefs = await SharedPreferences.getInstance();
    final jobs = prefs.getStringList('jobId');
    if(jobs != null)
      {
        _jobs = jobs;
      }
  }
  addBookMark(BookmarkRequest model, String jobId){
    BookMarkHelper.addBookmarks(model).then((response){
      // success hole 0 index a true and failed hole false
        if(response[0]){
          addJob(jobId);
          Get.snackbar("BookMark Successfully Added", "Please Check your Bookmark",
              colorText: Colors.white,
              backgroundColor: Colors.blue,
              icon: const Icon(Icons.bookmark_add)
          );
        }else if(!response[0]){
          Get.snackbar("Failed to Add BookMark", "Please try again",
              colorText: Colors.white,
              backgroundColor: Colors.red,
              icon: const Icon(Icons.bookmark_add)
          );
        }
    });

  }

  deleteBookMark(String jobId){
    BookMarkHelper.deleteBookmarks(jobId).then((response){
      // success hole 0 index a true and failed hole false
      if(response){
        removeJob(jobId);
        Get.snackbar("BookMark Successfully Deleted", "Please Check your Bookmark",
            colorText: Colors.white,
            backgroundColor: Colors.orangeAccent,
            icon: const Icon(Icons.bookmark_add)
        );
      }else if(!response){
        Get.snackbar("Failed to delete BookMark", "Please try again",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.bookmark_add)
        );
      }
    });

  }
  getBookMarks()
  {
    bookmarks = BookMarkHelper.getBookmarks();
  }
}