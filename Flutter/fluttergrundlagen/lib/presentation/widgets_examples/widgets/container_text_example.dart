import 'package:flutter/material.dart';

class ContainerTextExample extends StatelessWidget {
  const ContainerTextExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(
            color: Colors.black,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
            child: Material(
          borderRadius: BorderRadius.circular(16),
          elevation: 8,
          child: Container(
              alignment: Alignment.center,
              height: 100,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                "Text Example",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontFamily: "Rubik",
                  fontSize: 20,
                ),
              )),
        )));
  }
}
