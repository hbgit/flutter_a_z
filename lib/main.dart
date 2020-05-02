import 'package:flutter/material.dart';
import 'package:flutter_a_z/view/HomeScreen.dart';


void main() {
  runApp(MaterialApp(
    home: HomeScreen(url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"),
    debugShowCheckedModeBanner: false,
  ));
}