import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Utilities extends StatelessWidget {
  const Utilities({super.key});

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
    return const Placeholder();
  }
}