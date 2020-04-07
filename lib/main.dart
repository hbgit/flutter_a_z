import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phrases of the Day"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset("images/logo_main_book.jpg"),
              Text(
                "Hit the button to get a new phrase!",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  color: Colors.black
                ),
              ),
              RaisedButton(
                child: Text(
                  "New Phrase",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
                color: Colors.teal,
                onPressed: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
