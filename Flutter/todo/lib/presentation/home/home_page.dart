import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/auth/authbloc/auth_bloc.dart';

import '../routes/router.gr.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthStateUnathorized) {
            AutoRouter.of(context).push(const SignUpPageRoute());
          }
        })
      ],
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(SignOutPressedEvent());
                }),
            title: const Text('To Dos'),
          ),
          body: const Placeholder()),
    );
  }
}
