import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';

class SearchWidget extends StatelessWidget {
  final void Function()? onTap;
  const SearchWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*0.84,
                child: Row(
                  children: [
                    Icon(Icons.search,color: Colors.deepOrange, size: 20,),
                    SizedBox(width: 20,),
                    ReusableText(text: "Search for Job", style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500,color: Colors.deepOrange
                    ))
                  ],
                ),
              ),
Icon(FontAwesomeIcons.sliders,color: Colors.blueGrey,size: 20,)
            ],
          ),
          SizedBox(height: 7,),
          Divider(
            color: Colors.blueGrey,
            thickness: 0.5,
            endIndent: 40,
          )
        ],
      ),
    );
  }
}
