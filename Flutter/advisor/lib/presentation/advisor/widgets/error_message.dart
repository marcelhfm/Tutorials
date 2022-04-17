import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themData = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error, size: 40, color: Colors.redAccent),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Opps, Something went wrong. Please try again later.",
          style: themData.textTheme.headline1,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
