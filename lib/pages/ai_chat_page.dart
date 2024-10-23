import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';

class CustomChatTheme extends DefaultChatTheme {
  @override
  Decoration? get inputContainerDecoration => BoxDecoration(
        color: const Color(0xff1C4D85),
        borderRadius: BorderRadius.circular(20.0),
      );
}

class PatientInfoForm extends StatefulWidget {
  final Function(Map<String, String>) onSubmit;

  const PatientInfoForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<PatientInfoForm> createState() => _PatientInfoFormState();
}

class _PatientInfoFormState extends State<PatientInfoForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _queryController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _queryController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a mobile number';
    }
    final mobileRegex = RegExp(r'^\+?[1-9]\d{9,14}$');
    if (!mobileRegex.hasMatch(value)) {
      return 'Please enter a valid mobile number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Additional Information Required'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'To better assist you, please provide your contact information:',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _mobileController,
                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(),
                ),
                validator: _validateMobile,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _queryController,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  hintText: 'Enter your query or message here...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 4,
                keyboardType: TextInputType.multiline,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              widget.onSubmit({
                'full_name': _nameController.text,
                'email': _emailController.text,
                'mobile': _mobileController.text,
                'text': _queryController.text.isNotEmpty 
                    ? _queryController.text 
                    : 'No additional message provided',
                'is_followup': 'true',
              });
              Navigator.of(context).pop();
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
  final _botUser = const types.User(id: 'bot');
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _addBotMessage(
        "Hello! I'm your virtual assistant. How can I help you today?");
  }

  void _addBotMessage(String text) {
    final botMessage = types.TextMessage(
      author: _botUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: text,
    );

    setState(() {
      _messages.insert(0, botMessage);
    });
  }

  Future<void> _sendChatbotRequest(Map<String, dynamic> payload) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://62.72.27.109/chatbot'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        
        if (responseData['collect_info'] == true) {
          // Show the form to collect information
          if (!mounted) return;
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => PatientInfoForm(
              onSubmit: (patientInfo) async {
                await _sendChatbotRequest(patientInfo);
              },
            ),
          );
        } else {
          _addBotMessage(responseData['text']);
        }
      } else {
        _addBotMessage(
            "I apologize, but I'm having trouble processing your request. Please try again later.");
      }
    } catch (e) {
      _addBotMessage(
          "I apologize, but I'm having trouble connecting to the server. Please check your internet connection and try again.");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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

    await _sendChatbotRequest({'text': message.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Chat(
            messages: _messages,
            onSendPressed: _handleSendPressed,
            user: _user,
            theme: CustomChatTheme(),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}