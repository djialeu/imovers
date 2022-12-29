import 'package:flutter/material.dart';

import '../../models/ChatParams.dart';
import 'chat.dart';

class ChatScreen extends StatelessWidget {
  final ChatParams chatParams;

  const ChatScreen({Key? key, required this.chatParams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0.0,
          title: Text('Chat with ${chatParams.toUser}')
      ),
      body: Chat(chatParams: chatParams),
    );
  }
}