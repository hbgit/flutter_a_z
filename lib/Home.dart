import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    /*
    1) Logo Image
    2) Form - two inputs
    3) Button
    */
    return Scaffold(
      appBar: AppBar(
        title: Text("Álcool VS Gasolina"),
        backgroundColor: Colors.grey,
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(31),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //1) Logo Image
              Padding(
                padding: EdgeInsets.only(bottom: 31),
                child: Image.asset("images/logo_gasvsalc.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}