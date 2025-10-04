// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:homeus/main.dart';

void main() {
  testWidgets('Shows sign-in screen title', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Space Scout'), findsWidgets);
    expect(find.text('Welcome back!'), findsOneWidget);
  });
}
