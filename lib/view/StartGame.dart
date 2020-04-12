import 'package:flutter/material.dart';
import 'package:flutter_a_z/view/ResultGame.dart';
import 'dart:math';

class StartGame extends StatefulWidget {
  StartGame({Key key}) : super(key: key);

  @override
  _StartGameState createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {
  //Screen actions
  void _showResult(){
    var itens = ["cara", "coroa"];
    var num = Random().nextInt(itens.length);
    var result = itens[num];

    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => ResultGame(result)
      ),
    );

  }

  //Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff61bd86),
      body: Container(        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,          
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "images/v5_img/logo.png",
                  key: Key("logo_img"),
                  ),                
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 21),
                  child: GestureDetector(
                        onTap: () => _showResult(),
                        child: Image.asset(
                          "images/v5_img/botao_jogar.png",
                          key: Key("button_play"),
                          ),
                          key: Key("gesture_play"),
                      ),
                ),                 
              ],
            ),
          ],
        ),
      ),
    );
  }
}