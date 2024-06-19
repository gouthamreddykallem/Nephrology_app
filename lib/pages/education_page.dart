import 'package:flutter/material.dart';
import 'package:nephrology_app/components/topic_card.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/shared/education_data.dart';

class EducationBody extends StatelessWidget {
  const EducationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          elevation: 0,
          leading: const BackButton(
            color: Colors.black,
          ),
          title: const Text(
            "Education",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: bgColor,
        body: SafeArea(
            child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20.0),
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          crossAxisCount: 2,
          children: [for (final topic in topics) TopicItem(topic: topic)],
        )));
  }
}
