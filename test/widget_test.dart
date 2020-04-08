// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_a_z/main.dart';

void main() {
  testWidgets('Generate phrases testing', (WidgetTester tester) async {

    //final Key bodyKey = UniqueKey();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Home()
    ));

    // Verify the initial text is presented
    expect(find.text('Hit the button to get a new phrase!'), findsOneWidget);
    expect(find.byType(RaisedButton), findsOneWidget);    

    // Tap on RaisedButton to trigger a frame.
    await tester.tap(find.byType(RaisedButton));
    await tester.pump();

    // Verify if is generated a new phrase 
    expect(find.text('Hit the button to get a new phrase!'), findsNothing);    
  });
}
