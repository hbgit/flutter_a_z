// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

// From APP
import 'package:flutter_a_z/game/jokenPoGame.dart';

void main() {
  testWidgets('Checking JokenPo moves testing', (WidgetTester tester) async {
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: JokenPoGame()
    ));

    // Create the Finders.
    final SemanticsNode gameTextFinder = tester.getSemantics(find.byKey(Key('textMsg')));    
    final Finder rockOpFinder = find.byKey(Key('rock_op'));
    

    // Verify the inital screen
    expect(gameTextFinder.label, 'What is your move?');
    
    // Tap on each option of the game
    // 1 - rock
    await tester.tap(rockOpFinder);
    await tester.pump();    
    expect(gameTextFinder, findsNothing);    
    
  });
}
