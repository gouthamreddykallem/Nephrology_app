import 'package:flutter/material.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/shared/style.dart';

class DetailsPage extends StatefulWidget {
  final Map<String, String> details;
  const DetailsPage({super.key, required this.details});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    String? pointsString = widget.details['points'];
    List<String> points = pointsString?.split('\n') ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text(
          widget.details['title']!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        child: ListView(
          children: [
            if (widget.details['description']?.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  widget.details['description']!,
                  style: descriptionStyle,
                  // textAlign: TextAlign.justify,
                ),
              ),
            if (widget.details['heading']?.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  widget.details['heading']!,
                  style: descriptionStyle,
                ),
              ),
            if (points.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: points.map((point) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle,
                            size: 16.0, color: Colors.green),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            point
                                .trim(), // Trim to remove any leading/trailing spaces
                            style: descriptionStyle,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            if (widget.details['image']?.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Image.asset(widget.details['image']!,
                    fit: BoxFit.fill, alignment: Alignment.center),
              ),
          ],
        ),
      ),
    );
  }
}
