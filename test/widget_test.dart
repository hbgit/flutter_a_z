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
//import 'package:mockito/mockito.dart';

// Mock class
// class MockPlayer extends Mock implements FakePlayer {}

void main() {

  testWidgets('Checking Home Screen', (WidgetTester tester) async {

    // test code here
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: HomeScreen()
    ));
    
    /*
    final Finder appBarFinder = find.byKey(Key('app_bar')); 
    expect(appBarFinder, findsOneWidget); 

    final Finder bodyBarFinder = find.byKey(Key('body')); 
    expect(bodyBarFinder, findsOneWidget); 

    await tester.pump(new Duration(seconds: 60));      

    final Finder gesture = find.byType(GestureDetector); 
    expect(gesture, findsWidgets); 

    await tester.tap(gesture.first); 
    //await tester.pump(new Duration(seconds: 60));      
    await tester.pump(Duration.zero);
    //await tester.pumpAndSettle(Duration(seconds: 60));     
    */

  });

/*
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }
  
  testWidgets('Checking Player Screen', (WidgetTester tester) async {
    // Create mock object.
    var mocPlayer = FakePlayer();
    Future<bool> rtrue;

    //when(player.autoPlay()).
    //print(mocPlayer.resultAutoPlay);

    //when(mocPlayer.autoPlay()).thenReturn(Future.value(true));
    /*
    when(mocPlayer.autoPlay().then((value){
      if(value == true){
        //Future.delayed(Duration(seconds: 1), () => []);
        rtrue.whenComplete(() => true);
      }
    }));*/

    print('Running test');
    mocPlayer.autoPlay().then((value) async {
      print("Result testing: $value");
      rtrue = Future.value(value);
    });
    await tester.pump(new Duration(seconds: 60));
    //resultAutoPlay.then((value) => print("Result testing: $value"));
    //print("Result testing: $resultAutoPlay");

    PlayerScreen playScr = PlayerScreen(
      url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
      buildAutoPlay: rtrue
    );

    await tester.pumpWidget(makeTestableWidget(child: playScr));

    final Finder appBarFinder = find.byKey(Key('app_bar'));
    expect(appBarFinder, findsOneWidget);

    final Finder bodyBarFinder = find.byKey(Key('body'));
    expect(bodyBarFinder, findsOneWidget);

    Finder waiting = find.byType(CircularProgressIndicator);
    expect(waiting, findsOneWidget);

    await tester.pump(new Duration(seconds: 60));

    final Finder placeWave = find.byKey(Key('wave')); 
    expect(placeWave, findsOneWidget);

    final Finder pausebtn = find.byKey(Key('pause_btn')); 
    expect(pausebtn, findsOneWidget); 
    await tester.tap(pausebtn);
    await tester.pump(new Duration(seconds: 10));      

    final Finder stopbtn = find.byKey(Key('stop_btn')); 
    expect(stopbtn, findsOneWidget); 
    await tester.tap(stopbtn);
    await tester.pump(new Duration(seconds: 10));      

    final Finder mutebtn = find.byKey(Key('mute_btn')); 
    expect(mutebtn, findsOneWidget); 
    await tester.tap(mutebtn);
    await tester.pump(new Duration(seconds: 10));      


  });*/
}
