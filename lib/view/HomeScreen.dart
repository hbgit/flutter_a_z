import 'package:flutter/material.dart';
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

    List<Widget> screens = [
      Start(this._resultado),
      Text(""),
      Text(""),
      Text("")
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
                String res = await showSearch(context: context, delegate: null);
                setState(() {
                  this._resultado = res;
                });
              },
            ),
          ],
        )
      ),      
      body: (
        Container(
          padding: EdgeInsets.all(15),
          child: screens[this._indiceAtual],
        )
      ),      
      bottomNavigationBar: (
        BottomNavigationBar(
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
                title: Text("Subscription"),
                backgroundColor: Colors.deepOrange,
                icon:Icon(Icons.subscriptions)
              ),
              BottomNavigationBarItem(
                title: Text("Library"),
                backgroundColor: Colors.deepOrangeAccent,
                icon: Icon(Icons.folder)
              ),
          ],
        )
      ),      
    );
  }
}