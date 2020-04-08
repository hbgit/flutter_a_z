import 'package:flutter/material.dart';
import 'dart:math';

class JokenPoGame extends StatefulWidget {
  JokenPoGame({Key key}) : super(key: key);

  @override
  _JokenPoGameState createState() => _JokenPoGameState();
}

class _JokenPoGameState extends State<JokenPoGame> {
  
  // rules of the game
  var _imageAppPlay = AssetImage("images/padrao.png");
  var _msgApp       = "What is your move?";  
  AppBar _appBarMove = AppBar(
    title: Text('JokenPo Game'),
    backgroundColor: Colors.blue,
  );

  void _getMove(String userMove){
    var options = ["rock", "paper", "scissors"];
    var randomIndex = Random().nextInt(3);
    var appMove = options[randomIndex];

    switch (appMove) {
      case "rock":
        setState(() {
          this._imageAppPlay = AssetImage("images/pedra.png");
        });
        break;
      case "paper":
        setState(() {
          this._imageAppPlay = AssetImage("images/papel.png");
        });
        break;
      case "scissors":
        setState(() {
          this._imageAppPlay = AssetImage("images/tesoura.png");
        });
        break;      
    }

    //Checking the winner
    //In this option the user win
    if(
      (userMove == "rock" && appMove == "scissors") ||
      (userMove == "scissors" && appMove == "paper") ||
      (userMove == "paper" && appMove == "rock") 
    ){
      setState(() {
        this._msgApp = "You WIN :)";
        this._appBarMove = AppBar(
          title: Text('JokenPo Game'),
          backgroundColor: Colors.green,          
        );
      });
    }else if(
      (appMove == "rock" && userMove == "scissors") ||
      (appMove == "scissors" && userMove == "paper") ||
      (appMove == "paper" && userMove == "rock")
    ){
      setState(() {
        this._msgApp = "You LOST :(";
        this._appBarMove = AppBar(
          title: Text('JokenPo Game'),
          backgroundColor: Colors.redAccent,          
        );
      });
    }else{
      setState(() {
        this._msgApp = "We tied the Game :)";
        this._appBarMove = AppBar(
          title: Text('JokenPo Game'),
          backgroundColor: Colors.amber,          
        );
      });
    }

  }
  
  // app interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this._appBarMove
      /*
       AppBar(
        title: Text('JokenPo Game'),
        backgroundColor: Colors.blue,
      )*/
      ,
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
          //2) Image
          Image(
            image: this._imageAppPlay,
          ),
          //3) Text
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 17),
            child: Text(
              this._msgApp,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          //4) Row with 3 Image
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Image 1
              GestureDetector(
                onTap: () => this._getMove("rock"),
                child: Image.asset(
                  "images/pedra.png", 
                  height: 100,
                ),
                key: Key('rock_op'),
              ),
              // Image 2
              GestureDetector(
                onTap: () => this._getMove("paper"),
                child: Image.asset(
                  "images/papel.png", 
                  height: 100,
                ),
              ),
              // Image 3
              GestureDetector(
                onTap: () => this._getMove("scissors"),
                child: Image.asset(
                  "images/tesoura.png", 
                  height: 100,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}