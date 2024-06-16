import 'package:flutter/material.dart';
import 'package:nephrology_app/shared/color.dart';



class DetailsPage extends StatefulWidget {
  final Map<String, String> details;
  const DetailsPage({super.key, required this.details});

  @override
  State<DetailsPage> createState() =>
      _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text(widget.details['title']!),
      ),
      backgroundColor: bgColor,
    );
  }
}