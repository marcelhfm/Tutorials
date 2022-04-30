import 'package:advisor/presentation/advisor/widgets/advice_field.dart';
import 'package:advisor/presentation/advisor/widgets/custom_button.dart';
import 'package:advisor/presentation/advisor/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/advisor/advisor_bloc.dart';

class AdvicePageBody extends StatelessWidget {
  const AdvicePageBody({Key? key}) : super(key: key);

  static const adviceFieldKey = Key("adviceFieldKey");
  static const errorFieldKey = Key("errorFieldKey");
  static const initialTextKey = Key("initialTextKey");
  static const customButtonKey = Key("customButtonKey");

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Center(
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
                              style: themeData.textTheme.headline1,
                              key: initialTextKey);
                        } else if (adviceState is AdvisorStateLoading) {
                          return CircularProgressIndicator(
                              color: themeData.colorScheme.secondary);
                        } else if (adviceState is AdvisorStateLoaded) {
                          return AdviceField(
                              key: adviceFieldKey, advice: adviceState.advice);
                        } else if (adviceState is AdvisorError) {
                          return ErrorMessage(
                            key: errorFieldKey,
                            message: adviceState.message,
                          );
                        }
                        return const Placeholder();
                      }))),
          SizedBox(
            height: 200,
            child: Center(
              child: CustomButton(
                key: customButtonKey,
                onPressed: () {
                  BlocProvider.of<AdvisorBloc>(context)
                      .add(AdviceRequestEvent());
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
