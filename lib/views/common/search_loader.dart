import 'package:flutter/material.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';

class SearchLoading extends StatelessWidget {
  final String text;
  const SearchLoading({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
      ),
    );
  }
}