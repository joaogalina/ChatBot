import 'package:flutter/material.dart';

class UserMessage extends StatelessWidget {
  final String content;

  const UserMessage(this.content);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(8),
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
          child: Text(content),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.cyan,
          ),
        ),
      ],
    );
  }
}
