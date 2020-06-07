import 'package:flutter/material.dart';
import 'package:flutter_a_z/StartApp.dart';
//import 'package:flutter_a_z/controll/Auth.dart';
//import 'package:flutter_a_z/view/SplashView.dart';
//import 'package:flutter_a_z/controll/RouteGenerator.dart';
//import 'package:flutter_a_z/view/Login.dart';

void main() {

  // According to https://github.com/felangel/hydrated_bloc/issues/17
  WidgetsFlutterBinding.ensureInitialized();
  
  final StartApp myApp = StartApp(); 

  runApp(myApp);  
  
  


}