import 'package:flutter/material.dart';
import 'package:flutter_a_z/view/CustomSearchDelegate.dart';
import 'package:flutter_a_z/view/Start.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Screen Actions
  int _indiceAtual = 0;
  String _resultado = "";


  //Screen
  @override
  Widget build(BuildContext context) {
    print(this._resultado);
    List<Widget> screens = [      
      Start(this._resultado, "topDate"),
      Start("","hot"),
      Start("","view"),
      Start("","title")
    ];

    return Scaffold(
      appBar: (
        AppBar(
          iconTheme: IconThemeData(
            color: Colors.grey
          ),
          backgroundColor: Colors.white,
          title: Image.asset(
            "images/v7_img/youtube.png",
            width: 98,
            height: 22,
          ),
          actions: <Widget>[
            // search
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String res = await showSearch(context: context, delegate: CustomSearchDelegate());
                setState(() {                  
                  this._resultado = res;
                });
              },
            ),
          ],
          key: Key("app_bar"),
        )
      ),      
      body: (
        Container(
          padding: EdgeInsets.all(15),
          child: screens[this._indiceAtual],
          key: Key("body_app"),
        )        
      ),      
      bottomNavigationBar: (        
        BottomNavigationBar(
          key: Key("nav_App"),
          currentIndex: this._indiceAtual,
          onTap: (indice){
            setState(() {
              this._indiceAtual = indice;
            });
          },
          type: BottomNavigationBarType.shifting,
          items: [
              BottomNavigationBarItem(
                title: Text("Home"),
                backgroundColor: Colors.red,
                icon: Icon(Icons.home)
              ),
              BottomNavigationBarItem(
                title: Text("Hot"),
                backgroundColor: Colors.redAccent,
                icon: Icon(Icons.whatshot)
              ),
              BottomNavigationBarItem(
                title: Text("Highest Views"),
                backgroundColor: Colors.deepOrange,
                icon:Icon(Icons.subscriptions)
              ),
              BottomNavigationBarItem(
                title: Text("A-Z"),
                backgroundColor: Colors.deepOrangeAccent,
                icon: Icon(Icons.sort_by_alpha)
              ),
          ],
        )
      ),      
    );
  }
}