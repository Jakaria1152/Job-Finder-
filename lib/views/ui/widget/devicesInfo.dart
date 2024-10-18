import 'package:flutter/material.dart';
import 'package:job_finder_app/views/common/customOutlineBtn.dart';
import 'package:job_finder_app/views/common/reusable_text.dart';

class DevicesInfo extends StatelessWidget {
  final String location;
  final String device;
  final String platform;
  final String date;
  final String ipAddress;
  const DevicesInfo({super.key, required this.location, required this.device, required this.platform, required this.date, required this.ipAddress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusableText(text: platform, style: const TextStyle(
          fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold
        )),

        ReusableText(text: device, style: const TextStyle(
            fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold
        )),

        const SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(text: date, style: const TextStyle(
                    fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w400
                )),
                ReusableText(text: ipAddress, style: const TextStyle(
                    fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w400
                )),
              ],
            ),
            CustomOutlineButton(text: 'Sign Out', color: Colors.orange,onTap: (){

            },)
          ],
        )
      ],
    );
  }
}
