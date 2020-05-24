import 'package:flutter/material.dart';
import 'package:flutter_a_z/view/Login.dart';

void main() {

  // According to https://github.com/felangel/hydrated_bloc/issues/17
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(MaterialApp(
    home: Login(),
    debugShowCheckedModeBanner: false,    
  ));

}