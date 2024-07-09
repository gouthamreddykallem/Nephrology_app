import 'package:flutter/material.dart';
import 'package:nephrology_app/components/provider_card.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/shared/detail.dart';

class AllProvidersPage extends StatefulWidget {
  final String title;
  final List<List<Detail>> details;

  const AllProvidersPage(
      {super.key, required this.details, required this.title});

  @override
  State<AllProvidersPage> createState() => _AllProvidersPageState();
}

class _AllProvidersPageState extends State<AllProvidersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 2, // Allow the text to span up to 2 lines
          overflow: TextOverflow.ellipsis, // Handle overflow with an ellipsis
        ),
      ),
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.6, // Adjust this value to change the height
          ),
          itemCount: widget.details.length,
          itemBuilder: (context, index) {
            var details = widget.details[index];
            return ProviderCard(
              details: details,
            );
          },
        ),
      ),
    );
  }
}
