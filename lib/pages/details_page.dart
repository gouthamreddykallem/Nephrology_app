import 'package:flutter/material.dart';
import 'package:nephrology_app/components/provider_card.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/shared/detail.dart';
import 'package:nephrology_app/shared/style.dart';

class DetailsPage extends StatefulWidget {
  final List<Detail> details;
  const DetailsPage({super.key, required this.details});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Widget buildDescription(String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        description,
        style: descriptionStyle,
      ),
    );
  }

  Widget buildHeading(String heading) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        heading,
        style: headingStyle,
      ),
    );
  }

  Widget buildPoints(String pointsString) {
    List<String> points = pointsString.split('\n');
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: points.map((point) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle, size: 16.0, color: Colors.green),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    point.trim(),
                    style: descriptionStyle,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildImage(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Image.asset(
        imagePath,
        fit: BoxFit.fill,
        alignment: Alignment.center,
      ),
    );
  }

  Widget buildProviders(value) {
    String title = value[0].value;
    List<List<Detail>> providers = value[1];

    return Providers(title: title, providers: providers);
  }

  List<Widget> buildChildren() {
    final Map<String, Widget Function(dynamic)> builders = {
      'description': (value) => buildDescription(value as String),
      'heading': (value) => buildHeading(value as String),
      'image': (value) => buildImage(value as String),
      'points': (value) => buildPoints(value as String),
      'providerList': (value) => buildProviders(value),
    };

    List<Widget> children = [];

    for (var detail in widget.details) {
      var key = detail.key;
      var value = detail.value;

      if (builders.containsKey(key)) {
        children.add(builders[key]!(value));
      }
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    String? title;

    // Extract details from the list
    for (var detail in widget.details) {
      switch (detail.key) {
        case 'title':
          title = detail.value;
          break;
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text(
          title!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        child: ListView(
          children: buildChildren(),
        ),
      ),
    );
  }
}
