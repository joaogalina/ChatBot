import 'package:chat_bot/components/chat_window.dart';
import 'package:chat_bot/env/environment_variables.dart';
import 'package:chat_bot/components/input_form.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(ChatBot());

class ChatBot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, String>> messageList = [];

  Future<String> getResponseFromGPT(List<Map<String, String>> inputList) async {
    var apiKey = API_KEY;
    var url = 'https://api.openai.com/v1/chat/completions';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
    };

    var body = json.encode({
      'model': 'gpt-3.5-turbo',
      'messages': inputList,
      'temperature': 0.7,
      'max_tokens': 248,
      'n': 1,
    });

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      var output = jsonResponse['choices'][0]['message']['content'];
      return output;
    } else {
      return response.body;
    }
  }

  _submitInput(input) {
    setState(() {
      messageList.add({"role": "user", "content": input});
    });
    getResponseFromGPT(messageList).then((value) {
      setState(() {
        messageList.add({"role": "assistant", "content": value});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: Text('Chat Bot'));
    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: MediaQuery.of(context).viewInsets.bottom == 0
                ? availableHeight * 0.8
                : (availableHeight - MediaQuery.of(context).viewInsets.bottom) *
                    0.7,
            child: ChatWindow(messageList),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: InputForm(_submitInput),
          ),
        ],
      ),
    );
  }
}
