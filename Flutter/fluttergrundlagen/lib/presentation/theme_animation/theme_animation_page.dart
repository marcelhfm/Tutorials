import 'package:flutter/material.dart';
import 'package:fluttergrundlagen/presentation/theme_animation/widgets/moon.dart';
import 'package:fluttergrundlagen/presentation/theme_animation/widgets/star.dart';
import 'package:fluttergrundlagen/presentation/theme_animation/widgets/sun.dart';
import 'package:provider/provider.dart';

import '../../application/theme_service.dart';

class ThemeAnimationPage extends StatelessWidget {
  const ThemeAnimationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (context, themeService, child) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Theme Animation"),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Material(
                    borderRadius: BorderRadius.circular(15),
                    elevation: 20,
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(minWidth: double.infinity),
                      child: Container(
                          height: 500,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  colors: themeService.isDarkModeOn
                                      ? const [
                                          Color(0xFF94A9FF),
                                          Color(0xFF6B66CC),
                                          Color(0xFF200F75),
                                        ]
                                      : const [
                                          Color(0xDDFFFA66),
                                          Color(0xDDFFA057),
                                          Color(0xDD940B99)
                                        ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter)),
                          child: Stack(
                            children: [
                              AnimatedPositioned(
                                child: AnimatedOpacity(
                                    duration: const Duration(milliseconds: 300),
                                    opacity: themeService.isDarkModeOn ? 1 : 0,
                                    child: const Moon()),
                                top: themeService.isDarkModeOn ? 100 : 130,
                                right: themeService.isDarkModeOn ? 100 : -40,
                                duration: const Duration(milliseconds: 400),
                              ),
                              Positioned(
                                  top: 70,
                                  right: 50,
                                  child: AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      opacity:
                                          themeService.isDarkModeOn ? 1 : 0,
                                      child: const Star())),
                              Positioned(
                                  top: 150,
                                  left: 60,
                                  child: AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      opacity:
                                          themeService.isDarkModeOn ? 1 : 0,
                                      child: const Star())),
                              Positioned(
                                  top: 40,
                                  left: 200,
                                  child: AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      opacity:
                                          themeService.isDarkModeOn ? 1 : 0,
                                      child: const Star())),
                              Positioned(
                                  top: 50,
                                  left: 50,
                                  child: AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      opacity:
                                          themeService.isDarkModeOn ? 1 : 0,
                                      child: const Star())),
                              Positioned(
                                  top: 100,
                                  right: 200,
                                  child: AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      opacity:
                                          themeService.isDarkModeOn ? 1 : 0,
                                      child: const Star())),
                              AnimatedPadding(
                                duration: const Duration(milliseconds: 200),
                                padding: EdgeInsets.only(
                                    top: themeService.isDarkModeOn ? 110 : 50),
                                child: const Center(child: Sun()),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: themeService.isDarkModeOn
                                          ? Theme.of(context)
                                              .appBarTheme
                                              .backgroundColor
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15))),
                                  height: 225,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Test Heading",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .copyWith(fontSize: 24)),
                                      const SizedBox(height: 15),
                                      Text("Test Body",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 16)),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Dark Theme",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(fontSize: 16)),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Switch(
                                              value: themeService.isDarkModeOn,
                                              onChanged: (value) {
                                                Provider.of<ThemeService>(
                                                        context,
                                                        listen: false)
                                                    .toggleTheme();
                                              })
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    )))),
      );
    });
  }
}
