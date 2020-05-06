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

https://medium.com/flutter-comunidade-br/widget-test-787b81cf8996
*/


import 'package:flutter/material.dart';
import 'package:flutter_a_z/view/HomeScreen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() { 

  testWidgets('Checking Home Screen', (WidgetTester tester) async {

    // test code here
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: HomeScreen(urlJsonMusic: "assets/images/v9_img/json/songs.json")
    ));
    
    
    final Finder appBarFinder = find.byKey(Key('app_bar')); 
    expect(appBarFinder, findsOneWidget); 

    final Finder bodyBarFinder = find.byKey(Key('body')); 
    expect(bodyBarFinder, findsOneWidget); 

    await tester.pump(new Duration(seconds: 60));      

    final Finder gesture = find.byType(GestureDetector); 
    expect(gesture, findsWidgets); 

    await tester.tap(gesture.first); 
    await tester.pumpAndSettle(Duration(seconds: 60));     

  });


  


}

