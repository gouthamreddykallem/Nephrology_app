import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nephrology_app/pages/ai_chat_page.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/utilities/utils.dart';

class FloatingButtons extends StatelessWidget {
  const FloatingButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            onPressed: () {
              Utilities.urlLauncher(
                  Uri(scheme: 'tel', path: '+1-559-228-6600'));
            },
            tooltip: 'Contact Us',
            heroTag: 'contactUs',
            child: const Icon(Icons.call),
          ),
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const ChatDialog(),
                  );
                },
              );
            },
            tooltip: 'Chat Bot',
            heroTag: 'chatBot',
            child: SvgPicture.asset(
              'assets/chat.svg', // Replace with your SVG file path
              width: 36.0, // Adjust width as needed
              height: 36.0, // Adjust height as needed
            ),
          ),
        ],
      ),
    );
  }
}

class ChatDialog extends StatelessWidget {
  const ChatDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text('Chatbot'),
        ),
        body: const ChatScreen(),
      ),
    );
  }
}
