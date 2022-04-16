import 'package:flutter/material.dart';
import 'package:fluttergrundlagen/presentation/widgets_examples/widgets/container_text_example.dart';
import 'package:fluttergrundlagen/presentation/widgets_examples/widgets/custom_button.dart';
import 'package:fluttergrundlagen/presentation/widgets_examples/widgets/media_query_example.dart';
import 'package:fluttergrundlagen/presentation/widgets_examples/widgets/page_view_example.dart';
import 'package:fluttergrundlagen/presentation/widgets_examples/widgets/profile_pic.dart';
import 'package:fluttergrundlagen/presentation/widgets_examples/widgets/row_expanded_example.dart';

class WidgetsExamplesPage extends StatelessWidget {
  const WidgetsExamplesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          leading: const Icon(
            Icons.home,
            size: 30,
          ),
          centerTitle: true,
          title: const Text("Widgets Examples"),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                const ContainerTextExample(),
                const SizedBox(height: 30),
                const RowExpandedWidget(),
                const SizedBox(height: 30),
                const ProfilePicture(),
                const SizedBox(height: 30),
                const MediaQueryExample(),
                const SizedBox(height: 30),
                const PageViewExample(),
                const SizedBox(
                  height: 30,
                ),
                IconButton(
                    splashColor: Colors.blue,
                    onPressed: () {
                      print("Icon Button Pressed");
                    },
                    icon: const Icon(Icons.home, color: Colors.white)),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () {
                      print("Text Button pressed");
                    },
                    child: Container(
                        color: Colors.grey,
                        child: const Text("Button",
                            style: TextStyle(color: Colors.white)))),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  buttonColor: Colors.blue[300]!,
                  text: "Got to Screen 2",
                  onPressed: () {
                    Navigator.of(context).pushNamed("/screen2");
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  buttonColor: Colors.blue[200]!,
                  text: "Go to Screen 1",
                  onPressed: () {
                    Navigator.of(context).pushNamed("/screen1");
                  },
                )
              ],
            ),
          ),
        ));
  }
}
