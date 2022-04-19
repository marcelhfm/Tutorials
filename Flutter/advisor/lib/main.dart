import 'package:advisor/application/advisor/advisor_bloc.dart';
import 'package:advisor/injection.dart';
import 'package:advisor/presentation/advisor/advisor_page.dart';
import 'package:advisor/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: library_prefixes
import 'injection.dart' as IC;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IC.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advisor',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: BlocProvider(
        create: (BuildContext context) => sl<AdvisorBloc>(),
        child: const AdvisorPage(),
      ),
    );
  }
}
