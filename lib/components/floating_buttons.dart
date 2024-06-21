import 'package:flutter/material.dart';
import 'package:nephrology_app/pages/ai_chat_page.dart';
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
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const ChatDialog(),
                    ),
                  );
                },
              );
            },
            tooltip: 'Chat Bot',
            heroTag: 'chatBot',
            child: const Icon(Icons.chat_rounded),
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
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.all(0.0),
      child: const AiChatBody(),
    );
  }
}

