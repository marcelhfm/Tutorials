import 'package:flutter/material.dart';

class PageViewExample extends StatelessWidget {
  const PageViewExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.2,
      child: PageView(
        controller: PageController(viewportFraction: 0.95),
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 8),
              child: SinglePage(
                  size: size,
                  title: "Title 1",
                  text: "Das ist ein Text. Pizza Burger Sushi")),
          SinglePage(
              size: size,
              title: "Title 2",
              text: "Das ist ein Text. aDSasjkldhalsdkjh alskjhlsf"),
        ],
      ),
    );
  }
}

class SinglePage extends StatelessWidget {
  final Size size;
  final String title;
  final String text;

  const SinglePage(
      {Key? key, required this.size, required this.title, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size.height * 0.2,
        width: size.width * 0.85,
        decoration: BoxDecoration(
            color: Colors.grey[700], borderRadius: BorderRadius.circular(15)),
        child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const SizedBox(height: 20),
                Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ],
            )));
  }
}
