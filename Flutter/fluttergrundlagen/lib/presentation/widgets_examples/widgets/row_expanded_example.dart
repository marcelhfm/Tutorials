import 'package:flutter/material.dart';

class RowExpandedWidget extends StatelessWidget {
  const RowExpandedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: Colors.yellow,
          height: 100,
          width: 50,
        ),
        const SizedBox(width: 10),
        Expanded(
            child: Container(
          color: Colors.green,
          height: 100,
        )),
        const SizedBox(width: 10),
        Container(
          color: Colors.yellow,
          height: 100,
          width: 50,
        )
      ],
    );
  }
}
