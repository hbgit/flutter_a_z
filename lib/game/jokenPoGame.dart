import 'package:flutter/material.dart';
import 'dart:math';

class JokenPoGame extends StatefulWidget {
  JokenPoGame({Key key}) : super(key: key);

  @override
  _JokenPoGameState createState() => _JokenPoGameState();
}

class _JokenPoGameState extends State<JokenPoGame> {
  
  // rules of the game
  
  // app interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JokenPo Game'),
      ),
      body: Column(
        /* Items for the APP:
        1) Text
        2) Image
        3) Text
        4) Row with 3 Image
        */
        //1) Text
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 17),
            child: Text(
              "APP Choice:",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          //2) Image - STOP HERE
        ],
      ),
    );
  }
}