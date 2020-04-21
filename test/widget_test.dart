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
import 'package:flutter_a_z/view/HomeScreen.dart';
import 'package:flutter_a_z/view/Start.dart';
import 'package:flutter_test/flutter_test.dart';

void main() { 

  Widget snapshotText(BuildContext context, AsyncSnapshot<String> snapshot) {
    return Text(snapshot.toString(), textDirection: TextDirection.ltr);
  } 

  testWidgets('Checking Home Screen', (WidgetTester tester) async {
        
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: HomeScreen()
    ));
    
    
    final Finder appBarFinder = find.byKey(Key('app_bar')); 
    expect(appBarFinder, findsOneWidget); 

    final Finder bodyBarFinder = find.byKey(Key('body_app')); 
    expect(bodyBarFinder, findsOneWidget); 

    final Finder navBarFinder = find.byKey(Key('nav_App')); 
    expect(navBarFinder, findsOneWidget); 


    /*
    final Finder imgFinder = find.byKey(Key('img_bitcoin')); 
    expect(imgFinder, findsOneWidget);   

    final Finder resultTxtFinder = find.byKey(Key('result_txt')); 
    expect(resultTxtFinder, findsOneWidget); 

    //text_btn  
    final Finder btnTxtFinder = find.byKey(Key('text_btn')); 
    expect(btnTxtFinder, findsOneWidget); 

    //final Finder loadBtnFinder = find.byKey(Key('load_btn'));     
    //expect(loadBtnFinder, findsWidgets);   
    
    //await tester.tap(loadBtnFinder);   
    //await tester.pump();
    */

  });

  testWidgets('Checking Start Screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.  

    await tester.pumpWidget(MaterialApp(
      home: Start("","topDate")
    ));

    final Finder futureFinder = find.byKey(Key('frame_build_start')); 
    expect(futureFinder, findsOneWidget); 
    
    
    await tester.pumpWidget(FutureBuilder<String>(
        future: Future<String>.value('["zfBYJrhMZwQ"]'),
        builder: snapshotText,       
      ));

    await tester.pump(Duration.zero);

    /*
    final Finder listVideosFinder = find.byKey(Key('list_videos')); 
    expect(listVideosFinder, findsOneWidget); 

    final Finder imgVideoFinder = find.byKey(Key('img_video')); 
    expect(imgVideoFinder, findsOneWidget); 

    final Finder descVideoFinder = find.byKey(Key('list_desc_video')); 
    expect(descVideoFinder, findsOneWidget);    
    */


  });

}

