import 'package:advisor/application/advisor/advisor_bloc.dart';
import 'package:advisor/presentation/advisor/widgets/advice_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAdvisorBloc extends MockBloc<AdvisorEvent, AdvisorState>
    implements AdvisorBloc {}

class FakeAdvisorEvent extends Fake implements AdvisorEvent {}

class FakeAdvisorState extends Fake implements AdvisorState {}

class TestScaffoldWrapper extends StatelessWidget {
  final Widget child;
  const TestScaffoldWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: child,
    ));
  }
}

main() {
  late MockAdvisorBloc mockAdvisorBloc;

  setUp(() {
    mockAdvisorBloc = MockAdvisorBloc();
  });

  group("Advice page body", () {
    setUpAll(() {
      registerFallbackValue(FakeAdvisorState());
      registerFallbackValue(FakeAdvisorEvent());
    });

    //finders
    final initialText = find.byKey(AdvicePageBody.initialTextKey);
    final button = find.byKey(AdvicePageBody.customButtonKey);
    final errorMessage = find.byKey(AdvicePageBody.errorFieldKey);
    final progressIndicator = find.byType(CircularProgressIndicator);

    testWidgets("display inital text + button if state is inital",
        (WidgetTester tester) async {
      //arrange
      when((() => mockAdvisorBloc.state)).thenReturn(AdvisorInitial());

      //build
      await tester.pumpWidget(TestScaffoldWrapper(
        child: BlocProvider<AdvisorBloc>(
          create: (context) => MockAdvisorBloc(),
          child: const AdvicePageBody(),
        ),
      ));

      //check
      expect(initialText, findsOneWidget);
      expect(button, findsOneWidget);
      expect(errorMessage, findsNothing);
    });

    testWidgets("progressindicator if state is loading",
        (WidgetTester tester) async {
      //arrange
      when((() => mockAdvisorBloc.state)).thenReturn(AdvisorStateLoading());

      //build
      await tester.pumpWidget(TestScaffoldWrapper(
        child: BlocProvider<AdvisorBloc>(
          create: (context) => MockAdvisorBloc(),
          child: const AdvicePageBody(),
        ),
      ));

      //check
      expect(initialText, findsNothing);
      expect(progressIndicator, findsOneWidget);
      expect(button, findsOneWidget);
      expect(errorMessage, findsNothing);
    });

    testWidgets("errorMessage if state is error", (WidgetTester tester) async {
      //arrange
      when((() => mockAdvisorBloc.state))
          .thenReturn(AdvisorError(message: "error"));

      //build
      await tester.pumpWidget(TestScaffoldWrapper(
        child: BlocProvider<AdvisorBloc>(
          create: (context) => MockAdvisorBloc(),
          child: const AdvicePageBody(),
        ),
      ));

      //check
      expect(initialText, findsNothing);
      expect(progressIndicator, findsNothing);
      expect(button, findsOneWidget);
      expect(errorMessage, findsOneWidget);
    });
  });
}
