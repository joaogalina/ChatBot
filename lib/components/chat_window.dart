import 'package:chat_bot/components/bot_message.dart';
import 'package:chat_bot/components/user_message.dart';
import 'package:flutter/material.dart';

class ChatWindow extends StatelessWidget {
  Map<String,String> messageMap;

  ChatWindow(this.messageMap);

  List<Widget> get messages {
    final List<Widget> temp = [];
    messageMap.forEach((key, value) {
      temp.add(UserMessage(key));
      temp.add(BotMessage(value.substring(2)));
    });
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: messages,
      ),
    );
  }
}
