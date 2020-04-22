import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controllers
  TextEditingController _controllerTask = TextEditingController();
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
        backgroundColor: Colors.teal,
      ),
      
      body: Column(),
      
      //bottomNavigationBar: ,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_to_photos),
        backgroundColor: Colors.teal,
        onPressed: (){
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("Add a task"),
                content: TextField(                  
                  controller: this._controllerTask,
                  decoration: InputDecoration(
                    labelText: "Type your task",
                    //fillColor : Colors.purple
                  ),
                  onChanged: (text){

                  },                  
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Cancel"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  FlatButton(
                    child: Text("Save"),
                    onPressed: (){
                      // TODO: Add function
                      Navigator.pop(context);
                    },
                  )
                ],                
              );
            }
          );
        },
      ),
    );
  }
}