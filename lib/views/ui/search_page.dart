import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';
import 'package:job_finder_app/views/ui/widget/customField.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController search = TextEditingController();
  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  backgroundColor: Colors.deepOrange,
  iconTheme: IconThemeData(color: Colors.white),  // all item color white kore dibe
  title: CustomField(search: search,hintText: "Search for a Job",
  suffixIcon: GestureDetector(
    onTap: (){

    },
    child: Icon(Icons.search,size: 25,color: Colors.white,),
  ),
  ),
  elevation: 0,
),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icon/optimized search.jpg', fit: BoxFit.cover,),
              ReusableText(text: 'Start Searching for Jobs', style: TextStyle(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold
              ))
            ],
          ),
        ),
      ),
    );
  }
}


