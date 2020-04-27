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
import 'package:flutter_a_z/view/GetPriorityPickerDialog.dart';
import 'package:flutter_a_z/view/HomeScreen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() { 

  testWidgets('Checking Home Screen', (WidgetTester tester) async {
        
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: HomeScreen()
    ));
    
    
    final Finder appBarFinder = find.byKey(Key('app_bar')); 
    expect(appBarFinder, findsOneWidget); 

    final Finder bodyBarFinder = find.byKey(Key('body_app')); 
    expect(bodyBarFinder, findsOneWidget); 

    final Finder floatButFinder = find.byKey(Key('floatbut_app')); 
    expect(floatButFinder, findsOneWidget); 
    

  });


  testWidgets('Checking Dialog Screen', (WidgetTester tester) async {

    TextEditingController txtEdiCtrl = TextEditingController();
    txtEdiCtrl.text = "Buy a ticket";
        
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: GetPriorityPickerDialog(
        initialPriority: 0.0, 
        initCtrlTask: txtEdiCtrl
      )
    ));
       
    
    final Finder alertDiaFinder = find.byKey(Key('alert_dialog')); 
    expect(alertDiaFinder, findsOneWidget); 

    final Finder tfDiaFinder = find.byKey(Key("tf_dialog")); 
    expect(tfDiaFinder, findsOneWidget); 

    final Finder sliderDiaFinder = find.byKey(Key('slider_dia')); 
    expect(sliderDiaFinder, findsOneWidget); 
    
    final Finder flatButFinder = find.byKey(Key('flatBut_save')); 
    expect(flatButFinder, findsOneWidget); 
    

  });

  


}

