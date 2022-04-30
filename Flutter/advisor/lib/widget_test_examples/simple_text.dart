import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  static const messageKey = Key("messageWidget");
  const MyWidget({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(message, key: messageKey),
        ),
      ),
    );
  }
}
