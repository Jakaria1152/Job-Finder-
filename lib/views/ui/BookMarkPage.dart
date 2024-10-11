import 'package:flutter/material.dart';
import 'package:job_finder_app/controllers/bookmark_provider.dart';
import 'package:job_finder_app/model/response/Bookmark/all_bookmark.dart';
import 'package:provider/provider.dart';

import '../common/app_bar.dart';
import '../common/drawer/drawerWidget.dart';

class BookMarkPage extends StatelessWidget {
  const BookMarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppbar(
          text: 'BookMarks',

          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: DrawerWidget(),
          ),),
      ),
      body: Consumer<BookMarkNotifier>(
        builder: (context, bookmarkNotifier, child) {
          bookmarkNotifier.getBookMarks(); // at first get all bookmarks from server
        return FutureBuilder<List<AllBookMarkRes>>(
          // jobList take access kore neya hosse
          future: bookmarkNotifier.bookmarks,
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error is: ${snapshot.error}'),
              );
            } else {
              final bookmarks = snapshot.data;
// be careful return otherwise not find what happend error. because not use return does not show any info
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: bookmarks?.length,
                  itemBuilder: (context, index) {
                    final bookmark = bookmarks?[index];
                    return Container();
                  });
            }
          },
        );
      },),
    );
  }
}
