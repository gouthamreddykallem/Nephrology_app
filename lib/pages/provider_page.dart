import 'package:flutter/material.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/shared/detail.dart';

class ProviderPage extends StatefulWidget {
  final List<Detail> details;
  const ProviderPage({super.key, required this.details});

  @override
  State<ProviderPage> createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  @override
  Widget build(BuildContext context) {
    String? name;

    // Extract details from the list
    for (var detail in widget.details) {
      switch (detail.key) {
        case 'name':
          name = detail.value;
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
          name!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: bgColor,
    );
  }
}
