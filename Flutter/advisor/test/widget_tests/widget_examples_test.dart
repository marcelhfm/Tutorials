import 'package:advisor/widget_test_examples/simple_text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets("check if text is correct", (WidgetTester tester) async {
    const widgetKey = Key("myWidget");
    await tester.pumpWidget(
        const MyWidget(key: widgetKey, title: "title", message: "message"));

    final findTitle = find.text("title");
    final findMessage = find.byKey(MyWidget.messageKey);
    final findMyWidget = find.byKey(widgetKey);

    expect(findTitle, findsOneWidget);
    expect(findMessage, findsOneWidget);
    expect(findMyWidget, findsOneWidget);
  });
}
