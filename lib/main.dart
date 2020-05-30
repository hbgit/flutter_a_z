import 'package:flutter/material.dart';
import 'package:flutter_a_z/StartApp.dart';
import 'package:flutter_a_z/controll/Auth.dart';
//import 'package:flutter_a_z/controll/RouteGenerator.dart';
//import 'package:flutter_a_z/view/Login.dart';

void main() async {

  // According to https://github.com/felangel/hydrated_bloc/issues/17
  WidgetsFlutterBinding.ensureInitialized();
  final Auth _auth = Auth();
  final bool isLogged = await _auth.isLogged();
  final StartApp myApp = StartApp(
    initialRoute: isLogged ? '/home' : '/',
  );

  runApp(myApp);  
  
  /*
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(MaterialApp(
    home: Login(),
    debugShowCheckedModeBanner: false, 
    theme: ThemeData(
      primaryColor: Color(0xff075E54),
      accentColor: Color(0xff25D366)
    ), 
    initialRoute: RouteGenerator.ROUTE_ROOT,        
    onGenerateRoute: (settings){
      print("SETTINGS: ${settings.name}");
      return RouteGenerator.generateRoute(settings);
    },      
  ));*/


}