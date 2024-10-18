import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/controllers/bookmark_provider.dart';
import 'package:job_finder_app/controllers/job_provider.dart';
import 'package:provider/provider.dart';

import '../common/VerticalTile.dart';
import '../common/app_bar.dart';
import '../common/drawer/drawerWidget.dart';
import 'Jobs/job_page.dart';

class BookMarkPage extends StatelessWidget {
  const BookMarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final jobNotifier = Provider.of<JobNotifier>(context);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppbar(
          text: 'BookMarks',
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: DrawerWidget(),
          ),
        ),
      ),
      body: Consumer<BookMarkNotifier>(
        builder: (context, bookmarkNotifier, child) {
          bookmarkNotifier
              .getBookMarks(); // at first get all bookmarks from server
          return FutureBuilder(
            // jobList take access kore neya hosse
            future: bookmarkNotifier.bookmarks,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error is: ${snapshot.error}'),
                );
              } else {
                var bookmarks = snapshot.data;
// be careful return otherwise not find what happend error. because not use return does not show any info
                return bookmarks!.isNotEmpty
                    ? ListView.separated(
                        itemCount:
                            bookmarks.length, // total bookmarklist length
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        // scrollDirection: Axis.horizontal,

                        itemBuilder: (context, index) {
                          var bookmark =
                              bookmarks[index]; // single bookmark from list
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: VerticalTile(
                              job: bookmark.job,
                              onTap: () {
                                Get.to(JobPage(
                                    title: bookmark.job.company,
                                    id: bookmark.job.id));
                              },
                            ),
                          );
                        })
                    : const Center(
                        child:
                            Text("You haven't already created any bookmark"));
              }
            },
          );
        },
      ),
    );
  }
}
