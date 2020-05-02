import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_a_z/model/Music.dart';

class HomeScreen extends StatefulWidget {
  final String urlJsonMusic;

  HomeScreen({Key key, @required this.urlJsonMusic}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Attr
  List _songList = [];

  // Class actions
  Future<String> _loadAsset() async {
    //Map<bool,String> result;
    return await rootBundle.loadString(widget.urlJsonMusic);     
  }

  
  _getSongs() {
    _loadAsset().then((value){
      List jsonList = json.decode( value );
      jsonList.forEach((element) { 
        print(element);
        Music song = Music.fromJson(element);
        _songList.add(song);
      });
    });   
  }

  // Based on https://proandroiddev.com/flutter-thursday-02-beautiful-list-ui-and-detail-page-a9245f5ceaf0
  Widget createListItems(context, index) {    
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right:
                          new BorderSide(width: 1.0, color: Colors.white24))),
              child: Icon(
                Icons.headset_mic, 
                color: Colors.teal,
                size: 40,
              ),
            ),
            title: Text(
              _songList[index].name,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),        
            subtitle: Row(
              children: <Widget>[
                Icon(Icons.face, color: Colors.teal),
                Text(" ${_songList[index].artistName}", style: TextStyle(color: Colors.white))
              ],
            ),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.white, size: 30.0)),
      ),
    );
  }

  @override
  void initState() {        
    super.initState();    
    setState(() {
      _getSongs();
      //print(_songList);
    });
  }

  // Interface
  @override
  Widget build(BuildContext context) { 
    
    print(_songList);  

    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "MuSic PLayer",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _songList.length,
                itemBuilder: createListItems,
              ),
            )
          ],
        ),
      ),
    );
  }
}
