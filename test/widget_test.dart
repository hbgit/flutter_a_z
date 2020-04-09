// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

/*
Checking out:
https://github.com/bizz84/coding-with-flutter-login-demo/blob/master/test/login_page_test.dart
https://github.com/bizz84/coding-with-flutter-login-demo/blob/master/lib/login_page.dart
https://github.com/flutter/flutter/blob/master/packages/flutter_test/test/widget_tester_test.dart
*/

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
    final Finder rockImgFinder = find.byKey(Key('rock_img'));
    final Finder rockOpFinder = find.byKey(Key('rock_op'));
    final Finder paperImgFinder = find.byKey(Key('paper_img'));
    final Finder scisImgFinder = find.byKey(Key('scissors_img'));
    

    // Verify the inital screen
    expect(gameTextFinder.label, 'What is your move?');
    expect(rockImgFinder, findsOneWidget);
    expect(paperImgFinder, findsOneWidget);
    expect(scisImgFinder, findsOneWidget);
    
    // Tap on each option of the game
    // 1 - rock
    await tester.tap(rockOpFinder);
    await tester.pump(); 

    // 2 - paper
    //await tester.tap(paperOpFinder);
    //await tester.pump(); 

    // 3 - paper
    //await tester.tap(scisOpFinder);
    //await tester.pump(); 

  });
}
