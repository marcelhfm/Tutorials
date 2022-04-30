import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:nativedesign/theme.dart';
import 'package:nativedesign/utils/constants.dart';

import '../home/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool buttonValue = false;
  String switchText = "Don't";
  String usernameEntered = "";
  String passwordEntered = "";

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(
          title: const Text('Adaptive Design', style: toolbarTextStyle),
          cupertino: (_, __) => CupertinoNavigationBarData(
            transitionBetweenRoutes: false,
          ),
        ),
        body: ListView(
          children: [
            //Username
            Padding(
              padding: const EdgeInsets.only(
                  top: padding_50, left: padding_20, right: padding_20),
              child: PlatformTextField(
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  usernameEntered = text;
                },
                material: (_, __) => MaterialTextFieldData(
                  decoration: const InputDecoration(
                    labelText: username,
                  ),
                ),
                cupertino: (_, __) => CupertinoTextFieldData(
                  placeholder: username,
                ),
              ),
            ),
            //Password
            Padding(
              padding: const EdgeInsets.all(padding_20),
              child: PlatformTextField(
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  passwordEntered = text;
                },
                material: (_, __) => MaterialTextFieldData(
                    decoration: const InputDecoration(
                      labelText: password,
                    ),
                    obscureText: true),
                cupertino: (_, __) => CupertinoTextFieldData(
                    placeholder: password, obscureText: true),
              ),
            ),

            //switch
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(padding_20),
                    child: PlatformSwitch(
                      value: buttonValue,
                      onChanged: (value) {
                        setState(() {
                          buttonValue = value;
                          if (value) {
                            switchText = "Yes,";
                          } else {
                            switchText = "Don't";
                          }
                        });
                      },
                    )),
                Text(
                  "$switchText remember me",
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                )
              ],
            ),

            //Button
            Padding(
              padding: const EdgeInsets.all(padding_20),
              child: PlatformElevatedButton(
                onPressed: () {
                  if (usernameEntered.isEmpty || passwordEntered.isEmpty) {
                    showAlert(unPwError);
                  } else {
                    Navigator.pushReplacement(
                        context,
                        platformPageRoute(
                            context: context,
                            builder: (context) => const HomePage()));
                  }
                },
                child: const Text(login, style: TextStyle(color: Colors.white)),
                material: (_, __) => MaterialElevatedButtonData(),
                cupertino: (_, __) => CupertinoElevatedButtonData(),
              ),
            )
          ],
        ));
  }

  void showAlert(String message) {
    showPlatformDialog(
        context: context,
        builder: (_) {
          return PlatformAlertDialog(
            title: const Text(alert),
            content: Text(message),
            actions: [
              PlatformDialogAction(
                child: const Text(ok),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
