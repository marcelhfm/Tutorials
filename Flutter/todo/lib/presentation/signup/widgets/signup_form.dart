import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/auth/signupform/signupform_bloc.dart';
import 'package:todo/presentation/signup/widgets/signin_register_button.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String _email;
    late String _password;

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    String? validateEmail(String? input) {
      const emailRegex =
          r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

      if (input == null || input == '') {
        return 'Please enter an email';
      } else if (RegExp(emailRegex).hasMatch(input)) {
        _email = input;
        return null;
      } else {
        return "Please enter a valid email";
      }
    }

    String? validatePassword(String? input) {
      if (input == null || input == '') {
        return 'Please enter a password';
      } else if (input.length >= 6) {
        _password = input;
        return null;
      } else {
        return "Password has to be 6 characters or more";
      }
    }

    final themeData = Theme.of(context);

    return BlocConsumer<SignupformBloc, SignupformState>(
      listener: (context, state) {
        // TODO: Navigate to another page if auth is successful
        // TODO: Show error message if auth fails
      },
      builder: (context, state) {
        return Form(
            autovalidateMode: state.showValidationMessages
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text("Welcome",
                      style: themeData.textTheme.headline1!.copyWith(
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 4)),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Please Register or Sign in",
                      style: themeData.textTheme.headline1!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 4)),
                  const SizedBox(
                    height: 80,
                  ),
                  //Email
                  TextFormField(
                    validator: validateEmail,
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(labelText: "E-mail"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //Password
                  TextFormField(
                    validator: validatePassword,
                    cursorColor: Colors.white,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: "Password"),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SignInRegisterButton(
                    buttonText: "Sign In",
                    callback: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<SignupformBloc>(context).add(
                            SignInWithEmailAndPasswordPressed(
                                email: _email, password: _password));
                      } else {
                        BlocProvider.of<SignupformBloc>(context).add(
                            SignInWithEmailAndPasswordPressed(
                                email: null, password: null));

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Invalid input",
                              style: themeData.textTheme.bodyText1),
                          backgroundColor: Colors.redAccent,
                        ));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SignInRegisterButton(
                      buttonText: "Register",
                      callback: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<SignupformBloc>(context).add(
                              RegisterWithEmailAndPasswordPressed(
                                  email: _email, password: _password));
                        } else {
                          BlocProvider.of<SignupformBloc>(context).add(
                              RegisterWithEmailAndPasswordPressed(
                                  email: null, password: null));

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Invalid input",
                                style: themeData.textTheme.bodyText1),
                            backgroundColor: Colors.redAccent,
                          ));
                        }
                      }),
                  if (state.isSubmitting) ...[
                    const SizedBox(height: 20),
                    LinearProgressIndicator(
                        color: themeData.colorScheme.secondary)
                  ]
                ],
              ),
            ));
      },
    );
  }
}
