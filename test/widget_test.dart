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


// From APP
import 'package:flutter_a_z/Home.dart';

void main() {  

  testWidgets('Checking APP widgets', (WidgetTester tester) async {
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Home()
    ));

    final SemanticsHandle semanticsHandle = tester.ensureSemantics();

    
    final Finder logoImgFinder = find.byKey(Key('logo_img')); 
    expect(logoImgFinder, findsOneWidget);

    final Finder initTextFinder = find.byKey(Key('msg_init_text')); 
    expect(initTextFinder, findsOneWidget);

    final Finder inputTextGasFinder = find.byKey(Key('input_text_gas')); 
    expect(inputTextGasFinder, findsOneWidget);

    final Finder inputTextAlcFinder = find.byKey(Key('input_text_alc')); 
    expect(inputTextAlcFinder, findsOneWidget);

    final Finder butCalcFinder = find.byKey(Key('but_calc')); 
    expect(butCalcFinder, findsOneWidget);

    final Finder textResulFinder = find.byKey(Key('text_result')); 
    expect(textResulFinder, findsOneWidget);

    // Test Result alcool
    await tester.enterText(inputTextGasFinder, "3.59");
    await tester.enterText(inputTextAlcFinder, "1.45");    
    await tester.tap(butCalcFinder, pointer: 1);
    await tester.pump(const Duration(milliseconds: 100));
    
    final SemanticsNode nodeTextResult = tester.getSemantics(textResulFinder);
    final SemanticsData semanticsTxtRes = nodeTextResult.getSemanticsData();
    expect(semanticsTxtRes.label, "Melhor abastecer com alcool");
    semanticsHandle.dispose();    

    // Test Result gasolina
    await tester.enterText(inputTextGasFinder, "5.39");
    await tester.enterText(inputTextAlcFinder, "4.45");    
    await tester.tap(butCalcFinder, pointer: 1);
    await tester.pump(const Duration(milliseconds: 100)); 
    
    expect(semanticsTxtRes.label, "Melhor abastecer com gasolina");

  });
}
