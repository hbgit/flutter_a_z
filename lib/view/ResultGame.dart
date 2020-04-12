import 'package:flutter/material.dart';

class ResultGame extends StatefulWidget {
  
  final String coinSide;

  ResultGame(this.coinSide);

  @override
  _ResultGameState createState() => _ResultGameState();
}

class _ResultGameState extends State<ResultGame> {
    
  //Screen
  @override
  Widget build(BuildContext context) {

    //Screen Actions
    var imgPath;
    if(widget.coinSide == "cara"){
      imgPath = "images/v5_img/moeda_cara.png";
    }else{
      imgPath = "images/v5_img/moeda_coroa.png";
    }


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
                  imgPath,
                  key: Key("img_result"),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 21),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "images/v5_img/botao_voltar.png",
                      key: Key("button_back"),
                      ),
                  )
                ],
              ),
            )        
          ],
        ),
      ),
    );
  }
}