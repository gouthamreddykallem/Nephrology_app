import 'package:flutter/foundation.dart';
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
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');

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
      Uri.parse('http://192.168.4.137:5000/chat'),
      // Uri.parse('http://127.0.0.1:5000/chat'),  // For iOS simulator or web
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': message.text}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final botMessage = types.TextMessage(
        author: const types.User(id: 'bot'),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: responseData['response'],
      );

      setState(() {
        _messages.insert(0, botMessage);
      });
    } else {
      // Handle error
      if (kDebugMode) {
        print('Failed to get response from the chatbot');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,
        theme: CustomChatTheme(),
      ),
    );
  }
}
