// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// From APP
import 'package:flutter_a_z/game/jokenPoGame.dart';

void main() {
  testWidgets('Checking JokenPo moves testing', (WidgetTester tester) async {
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: JokenPoGame()
    ));

    // Verify the initial text is presented
    expect(find.text('What is your move?'), findsOneWidget);
    expect(find.byType(GestureDetector), findsOneWidget);    

    // Tap on each option of the game
    // 1 - paper
    await tester.tap(find.byWidget(Image.asset("images/pedra.png")) );
    await tester.pump();    
    expect(find.text('What is your move?'), findsNothing);    
    
  });
}
