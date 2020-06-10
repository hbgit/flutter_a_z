import 'package:flutter/material.dart';
import 'package:flutter_a_z/controll/RouteGenerator.dart';

class StartApp extends StatelessWidget {
    
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      //home: SplashView(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xff075E54), accentColor: Color(0xff25D366)),
      //initialRoute: "/splash",
      onGenerateRoute: (settings) {
        //print(">>" + route);
        print("SETTINGS: ${settings.name}");
        return RouteGenerator.generateRoute(settings);
      },
      
    );
  }
}


/*
MaterialApp(
      //home: Login(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xff075E54), accentColor: Color(0xff25D366)),
      initialRoute: initialRoute,
      onGenerateRoute: (settings) {
        print(initialRoute);
        print("SETTINGS: ${settings.name}");
        return RouteGenerator.generateRoute(settings);
      },
    );
*/
