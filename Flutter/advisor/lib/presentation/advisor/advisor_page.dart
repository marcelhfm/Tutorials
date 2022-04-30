import 'package:advisor/presentation/advisor/widgets/advice_page_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/theme/theme_service.dart';

class AdvisorPage extends StatelessWidget {
  const AdvisorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          actions: [
            Visibility(
              visible: !Provider.of<ThemeService>(context).useSystemTheme,
              child: Switch(
                  value: Provider.of<ThemeService>(context).isDarkModeOn,
                  onChanged: (_) {
                    Provider.of<ThemeService>(context, listen: false)
                        .toggleTheme();
                  }),
            ),
            const Text("System: "),
            Switch(
                value: Provider.of<ThemeService>(context).useSystemTheme,
                activeColor: Colors.redAccent,
                onChanged: (_) {
                  Provider.of<ThemeService>(context, listen: false)
                      .toggleUseSystemTheme();
                })
          ],
          title: Text("Advisor", style: themeData.textTheme.headline1),
        ),
        body: const AdvicePageBody());
  }
}
