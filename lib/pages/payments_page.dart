import 'package:flutter/material.dart';
import 'package:nephrology_app/shared/color.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

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
            "Payments",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: bgColor,
        body: SafeArea(child: Container()));
  }
}
