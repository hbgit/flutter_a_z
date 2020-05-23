import 'package:flutter/material.dart';
import 'package:flutter_a_z/view/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {

  // According to https://github.com/felangel/hydrated_bloc/issues/17
  WidgetsFlutterBinding.ensureInitialized();
  
  
  Firestore.instance
  .collection("users")
  .document("002")
  .setData({"name":"Ivaneide"});

  runApp(MaterialApp(
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,    
  ));

}