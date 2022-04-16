import 'package:flutter/material.dart';
import 'package:fluttergrundlagen/presentation/widgets_examples/widgets/custom_button.dart';

class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: const Text("Screen 2"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  buttonColor: Colors.yellow,
                  text: "Navigate Back"),
              const SizedBox(height: 30),
              CustomButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed("/screen1");
                  },
                  buttonColor: Colors.yellow,
                  text: "Go to Screen 1"),
            ],
          ),
        ));
  }
}
