import 'package:flutter/material.dart';

import 'package:flutter_a_z/view/AddUser.dart';
import 'package:flutter_a_z/view/HomeScreen.dart';
import 'package:flutter_a_z/view/Login.dart';
import 'package:flutter_a_z/view/Messages.dart';
import 'package:flutter_a_z/view/Settings.dart';
import 'package:flutter_a_z/view/SplashView.dart';

class RouteGenerator {
  
  static const String ROUTE_ROOT = "/";
  static const String ROUTE_HOME = "/home";
  static const String ROUTE_LOGIN = "/login";
  static const String ROUTE_MSG = "/message";
  static const String ROUTE_SPLASH = "/splash";
  static const String ROUTE_ADD_USER = "/adduser";
  static const String ROUTE_SETTINGS = "/settings";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    
    print("ROUTE set: " + settings.toString());
    //print(ROUTE_HOME);

    var args = settings.arguments;

    switch (settings.name) {
      case ROUTE_SPLASH:
        return MaterialPageRoute(            
            builder: (_) => SplashView());      
      case ROUTE_ROOT:
        return MaterialPageRoute(
            // "_" not allocate memory to var
            builder: (_) => SplashView());
      case ROUTE_LOGIN:
        return MaterialPageRoute(builder: (_) => Login());
      case ROUTE_MSG:
        return MaterialPageRoute(builder: (_) => Messages(user: args));
      case ROUTE_ADD_USER:
        return MaterialPageRoute(builder: (_) => AddUser());
      case ROUTE_HOME:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case ROUTE_SETTINGS:
        return MaterialPageRoute(builder: (_) => Settings());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Screen not found"),
            ),
            body: Center(
              child: Text("Sorry, I don't found your screen :("),
            ),
          );
        });
    }
  }  
}
