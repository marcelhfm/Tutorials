import 'package:advisor/application/advisor/advisor_bloc.dart';
import 'package:advisor/presentation/advisor/widgets/advice_field.dart';
import 'package:advisor/presentation/advisor/widgets/custom_button.dart';
import 'package:advisor/presentation/advisor/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        body: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              Expanded(
                  child: Center(
                      child: BlocBuilder<AdvisorBloc, AdvisorState>(
                          bloc: BlocProvider.of<AdvisorBloc>(context),
                          builder: (context, adviceState) {
                            if (adviceState is AdvisorInitial) {
                              return Text("Advice is waiting for you!",
                                  style: themeData.textTheme.headline1);
                            } else if (adviceState is AdvisorStateLoading) {
                              return CircularProgressIndicator(
                                  color: themeData.colorScheme.secondary);
                            } else if (adviceState is AdvisorStateLoaded) {
                              return AdviceField(advice: adviceState.advice);
                            } else if (adviceState is AdvisorError) {
                              return ErrorMessage(
                                message: adviceState.message,
                              );
                            }
                            return const Placeholder();
                          }))),
              SizedBox(
                height: 200,
                child: Center(
                  child: CustomButton(
                    onPressed: () {
                      BlocProvider.of<AdvisorBloc>(context)
                          .add(AdviceRequestEvent());
                    },
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
