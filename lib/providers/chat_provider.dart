import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/api_config.dart';

class Message {
  final String content;
  final bool isUser;

  Message({required this.content, required this.isUser});

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'isUser': isUser,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'],
      isUser: json['isUser'],
    );
  }
}

class ChatProvider with ChangeNotifier {
  final ApiConfig apiService = ApiConfig();
  List<Message> _messages = [];
  bool _isLoading = false;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedMessages = prefs.getString('chatHistory');
    
    if (storedMessages != null) {
      List<dynamic> decodedList = json.decode(storedMessages);
      _messages = decodedList.map((message) => 
        Message.fromJson(message)
      ).toList();
      notifyListeners();
    }
  }

  Future<void> sendMessage(String messageText) async {
    _isLoading = true;
    notifyListeners();

    // Add user message
    _messages.add(Message(content: messageText, isUser: true));
    await _saveMessages();

    // Prepare context
    String context = _messages
        .map((message) => '${message.isUser ? 'user' : 'bot'}: ${message.content}')
        .join('\n');

    String prompt = '''
You are an assistant specialized in answering questions briefly and accurately.

Conversation context: $context

User's question: $messageText

Respond concisely, with a maximum of 2 to 3 sentences.
''';

    // Get bot response
    String botResponse = await apiService.getResponse(prompt);

    // Add bot message
    _messages.add(Message(content: botResponse, isUser: false));
    
    _isLoading = false;
    await _saveMessages();
    notifyListeners();
  }

  Future<void> _saveMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('chatHistory', json.encode(
      _messages.map((message) => message.toJson()).toList()
    ));
  }

  void clearChat() {
    _messages.clear();
    _saveMessages();
    notifyListeners();
  }
}