import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:nativedesign/presentation/home/platform_wrapper.dart';

import '../../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(
          title: const Text('Examples', style: toolbarTextStyle),
          cupertino: (_, __) => CupertinoNavigationBarData(
            transitionBetweenRoutes: false,
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            PlatformSlider(
                value: value,
                onChanged: (v) {
                  setState(() {
                    value = v;
                  });
                }),
            PlatformIconButton(
              onPressed: () {
                print("pressed");
              },
              materialIcon: const Icon(Icons.info),
              cupertinoIcon: const Icon(CupertinoIcons.info),
            ),
            Icon(PlatformIcons(context).info),
            const SizedBox(height: 30),
            PlatformCircularProgressIndicator(),
            const SizedBox(height: 30),
            PlatformWidget(
              material: (_, __) =>
                  Container(height: 20, width: 40, color: Colors.blueAccent),
              cupertino: (_, __) =>
                  Container(height: 20, width: 40, color: Colors.redAccent),
            ),
            const SizedBox(height: 30),
            PlatWrapper(
              material:
                  Container(height: 20, width: 40, color: Colors.blueAccent),
              cupertino:
                  Container(height: 20, width: 40, color: Colors.redAccent),
            ),
            const SizedBox(height: 30),
            PlatformWidgetBuilder(
              material: (_, child, __) => InkWell(
                  child: child,
                  onTap: () {
                    print("Tap");
                  }),
              cupertino: (_, child, __) => GestureDetector(
                  onTap: () {
                    print("Tap iOS");
                  },
                  child: child),
              child: Container(
                  height: 50,
                  width: 100,
                  color: Colors.teal,
                  child: const Center(
                    child: Text("button"),
                  )),
            )
          ],
        )));
  }
}
