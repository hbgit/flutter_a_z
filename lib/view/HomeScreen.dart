import 'package:flutter/material.dart';
import 'package:flutter_a_z/controll/CollectPrice.dart';
//import 'package:flutter_a_z/controll/CollectPrice.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Scree Actions
  String _price = "0";
    
  void _getPriceText(){
    CollectPrice _collectPrice = CollectPrice();
    _collectPrice.collectBitPrice().then((value) {
      if(_collectPrice.codStatus == 200){
        setState(() {
          _price = _collectPrice.price; 
          print(_price);
        });      
        }
    });       
  } 
    

  // Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preço do Bitcoin"),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        padding: EdgeInsets.all(31),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("images/v6_img/bitcoin.png"),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  "R\$ " + this._price,
                  style: TextStyle(
                    fontSize: 35
                  ),
                ),
              ),
              RaisedButton(
                child: Text(
                  "Atualizar",
                  style: TextStyle(
                    fontSize: 21,
                    color: Colors.white
                  ),
                ),
                color: Colors.orange,
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                onPressed: () => this._getPriceText(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}