import 'package:flutter/material.dart';
import 'package:flutter_a_z/view/HomeScreen.dart';


void main() {
  runApp(MaterialApp(
    home: HomeScreen(urlJsonMusic: "assets/images/v9_img/json/songs.json",),
    debugShowCheckedModeBanner: false,    
  ));
}