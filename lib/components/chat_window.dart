import 'package:chat_bot/components/bot_message.dart';
import 'package:chat_bot/components/user_message.dart';
import 'package:flutter/material.dart';

class ChatWindow extends StatelessWidget {
  List<Map<String,String>> messageList;

  ChatWindow(this.messageList);

  List<Widget> get messages {
    final List<Widget> temp = [];
    // messageList.forEach((key, value) {
    //   temp.add(UserMessage(key));
    //   temp.add(BotMessage(value));
    // });
    messageList.forEach((message) {
      if(message["role"] == "user"){
        temp.add(UserMessage(message["content"]!));
      }else if(message["role"] == "assistant"){
        temp.add(BotMessage(message["content"]!));
      }
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
