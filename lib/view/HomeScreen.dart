import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Screen Actions


  //Screen
  @override
  Widget build(BuildContext context) {
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
              onPressed: (){
                print("search icon");
              },
            ),
          ],
        )
      ),      
      body: (
        Container(
          padding: EdgeInsets.all(15),
          // Move screen
        )
      ),      
      bottomNavigationBar: (
        BottomNavigationBar(
          currentIndex: 0,
          //onTap: (){},
          type: BottomNavigationBarType.shifting,
          items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.cyan,
                icon: Icon(Icons.home)
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.red,
                icon: Icon(Icons.whatshot)
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.orange,
                icon:Icon(Icons.subscriptions)
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.green,
                icon: Icon(Icons.folder)
              ),
          ],
        )
      ),      
    );
  }
}