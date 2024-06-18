import 'package:flutter/material.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/shared/topic.dart';

class TopicPage extends StatefulWidget {
  final Topic topic;
  const TopicPage({super.key, required this.topic});

  @override
  State<TopicPage> createState() => _AllProvidersPageState();
}

class _AllProvidersPageState extends State<TopicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text(widget.topic.title),
      ),
    );
  }
}
