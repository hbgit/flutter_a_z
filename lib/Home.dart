import 'package:flutter/material.dart';
import 'package:flutter_a_z/controller/CalcOpt.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controllerAlcool = TextEditingController();
  TextEditingController _controllerGasolina = TextEditingController();
  String _textoResultado = "";

  void _calcular(){
    double precoAlcool = double.tryParse( _controllerAlcool.text );
    double precoGasolina = double.tryParse( _controllerGasolina.text );
    
    CalcOpt runCalc = CalcOpt(precoAlcool, precoGasolina);
    
    //check if the input is validate
    if (!runCalc.isValidaInput()){
      setState(() {
        _textoResultado = "Número inválido, digite números maiores que 0 e utilizando (.) ";
      });
    }else{
      // calc the best choice
      if( runCalc.calcOpt() == "gasolina" ){
        setState(() {
          _textoResultado = "Melhor abastecer com gasolina";
        });
      }else{
        setState(() {
          _textoResultado = "Melhor abastecer com alcool";
        });
      }
    }

  }
  

  @override
  Widget build(BuildContext context) {
    /*
    1) Logo Image
    2) Text
    3) Form - two inputs
    4) Button
    5) Result text
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
              //2) Text
              Padding(
                padding: EdgeInsets.only(bottom: 11),
                child: Text(
                  "Qual é a melhor escolha?",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              //3) Form - two inputs
              // 3.1) - Input Text
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Preço da Gasolina, ex: 3.59",                  
                ),
                style: TextStyle(
                  fontSize: 22
                ),
                controller: _controllerGasolina,
              ),
              // 3.2) - Input Text
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Preço do Álcool, ex: 1.59"
                ),
                style: TextStyle(
                  fontSize: 22
                ),
                controller: _controllerAlcool,
              ),
              //4) Button
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  color: Colors.grey,
                  textColor: Colors.black,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Calcular",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  onPressed: _calcular,
                ),
              ),
              //5) Result text
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  _textoResultado,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}