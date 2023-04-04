import 'package:chat_bot/components/chat_window.dart';
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
  String? _response;
  Map<String, String> messageMap = {};

  Future<String> getResponseFromGPT(String input) async {
    var apiKey = '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';
    var url = 'https://api.openai.com/v1/engines/text-davinci-003/completions';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
    };

    var body = json.encode({
      'prompt': input,
      'temperature': 0.7,
      'max_tokens': 248,
      'n': 1,
    });

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      var output = jsonResponse['choices'][0]['text'];
      return output;
    } else {
      return response.body;
    }
  }

  _submitInput(input) {
    getResponseFromGPT(input).then((value) {
      setState(() {
        _response = value;
        messageMap.addAll({input: _response!});
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
            height: MediaQuery.of(context).viewInsets.bottom == 0 ? availableHeight * 0.8 : (availableHeight - MediaQuery.of(context).viewInsets.bottom) * 0.7,
            child: ChatWindow(messageMap),
          ),
          InputForm(_submitInput),
        ],
      ),
    );
  }
}
