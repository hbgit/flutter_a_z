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
https://flutter.dev/docs/testing
*/


import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_a_z/view/StartGame.dart';
import 'package:flutter_a_z/view/ResultGame.dart';


void main() {  

  testWidgets('Checking Start Game Screen', (WidgetTester tester) async {
        
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: StartGame()
    ));

    // final SemanticsHandle semanticsHandle = tester.ensureSemantics();

    
    final Finder logoImgFinder = find.byKey(Key('logo_img')); 
    expect(logoImgFinder, findsOneWidget);    

    final Finder butPlayFinder = find.byKey(Key('button_play')); 
    expect(butPlayFinder, findsOneWidget);   

    final Finder gestPlayFinder = find.byKey(Key('gesture_play')); 
    expect(gestPlayFinder, findsOneWidget); 
    
    //await tester.tap(gestPlayFinder);   
    //await tester.pump();

  });

  testWidgets('Checking Result Game Screen', (WidgetTester tester) async {
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: ResultGame("cara")
    ));

    // final SemanticsHandle semanticsHandle = tester.ensureSemantics();

    
    final Finder resultImgFinder = find.byKey(Key('img_result')); 
    expect(resultImgFinder, findsOneWidget);    

    final Finder butBackFinder = find.byKey(Key('button_back')); 
    expect(butBackFinder, findsOneWidget);      

  });

}

