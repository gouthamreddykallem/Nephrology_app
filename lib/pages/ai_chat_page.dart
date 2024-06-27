import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';

class CustomChatTheme extends DefaultChatTheme {
  @override
  Decoration? get inputContainerDecoration => BoxDecoration(
    color: const Color(0xff1C4D85), // Custom input field color
    borderRadius: BorderRadius.circular(20.0), // Custom border radius
  );
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<types.Message> _messages = [];
  final _user = types.User(id: const Uuid().v4());

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    setState(() {
      _messages.insert(0, textMessage);
    });

    final response = await http.post(
      Uri.parse('http://localhost:5005/webhooks/rest/webhook'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'sender': 'user', 'message': message.text}),
    );

    final List<dynamic> responseData = jsonDecode(response.body);
    for (var element in responseData) {
      final botMessage = types.TextMessage(
        author: const types.User(id: 'bot'),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: element['text'],
      );

      setState(() {
        _messages.insert(0, botMessage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chat(
      messages: _messages,
      onSendPressed: _handleSendPressed,
      user: _user,
      theme: CustomChatTheme(),
    );
  }
}
