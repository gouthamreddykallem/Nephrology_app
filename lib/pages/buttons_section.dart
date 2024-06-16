import 'package:flutter/material.dart';
import 'package:nephrology_app/components/floating_buttons.dart';

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      // textStyle: const TextStyle(
      //     fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
      // iconColor: Colors.blue,
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
    );
    // final Color color = Theme.of(context).primaryColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      // mainAxisSpacing: 8.0,
      children: [
        // const SizedBox(height: 5), // Spacing between buttons
        ElevatedButton(
          style: style,
          // Button 1 style and properties
          onPressed: () {
            FloatingButtons.urlLauncher(
                Uri.parse('https://www.myhealthrecord.com/Portal/SSO'));
          },
          child: const Text('PATIENT PORTAL'),
        ),
        // const SizedBox(height: 5), // Spacing between buttons
        ElevatedButton(
          style: style,
          // Button 2 style and properties
          onPressed: () {
            FloatingButtons.urlLauncher(Uri.parse(
                'https://www.thenephrologygroupinc.com/Portals/0/Online%20Forms/Forms%202-12-2018/NewPatientRF.pdf?ver=2018-02-16-140849-517'));
          },
          child: const Text('REFER A PATIENT'),
        ),
        // const SizedBox(height: 16), // Spacing between buttons
      ],
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        description,
        softWrap: true,
      ),
    );
  }
}
