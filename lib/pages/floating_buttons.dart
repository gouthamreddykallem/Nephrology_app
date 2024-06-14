import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class FloatingButtons extends StatelessWidget {
  const FloatingButtons({super.key});
 static urlLauncher(Uri url) async {
    // const url = ;   
    if (await canLaunchUrl(url)) {
       await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }   
}
  @override
  Widget build(BuildContext context) {
    return Padding(
    // mainAxisAlignment: MainAxisAlignment.end,
    padding: const EdgeInsets.only(left: 30),
    child : Row(
    children: [
      FloatingActionButton(
        onPressed: () {
          urlLauncher( Uri(scheme: 'tel', path: '+1-559-228-6600'));
          //...
        },
        tooltip: 'Contact Us',
        heroTag: null,
        child: const Icon(
          Icons.call
        ),
      ),
      const SizedBox(
        width: 300,
      ),
      // FloatingActionButton(           
      //   onPressed: () {

      //   },
      //   heroTag: null,           
      //   child: const Icon(
      //     Icons.chat
      //   ),
      // )
    ]
    )
  );
  }
}