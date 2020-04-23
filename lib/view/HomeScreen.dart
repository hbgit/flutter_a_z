import 'package:flutter/material.dart';
import 'package:flutter_a_z/model/Task.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controllers
  TextEditingController _controllerTask = TextEditingController();

  // attr
  List _taskList = [];
  Task _lastTaskUsed = Task();

  //Handle File

  Future<File> _getFile() async {
    final pathAppDir = await getApplicationDocumentsDirectory();
    return File("${pathAppDir.path}/data_task.json");
  }

  _saveFile() async {
    var fileTask = await _getFile();
    List saveTask = Task().getMapListTask(_taskList);
    String data = json.encode(saveTask);

    print("Data to be saved:");
    print(data);

    fileTask.writeAsString(data);
  }

  _readFile() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Handle tasks
  _saveTask() {
    String typedText = _controllerTask.text;

    Task task = Task();
    task.description = typedText;
    task.status = false;
    task.id = DateTime.now().millisecondsSinceEpoch.toString();

    setState(() {
      _taskList.add(task);
    });

    _saveFile();
    _controllerTask.text = "";
  }

  // For APP
  @override
  void initState() {
    super.initState();

    _readFile().then((data) {
      setState(() {
        _taskList = Task().getListTaskFromJsonString(data);
      });
    });
  }

  // ListView using Dismissible of this Screen
  Widget createListItems(context, index) {
    return Dismissible(
      key: Key(UniqueKey().toString()),
      //key: Key(_taskList[index].id),
      //direction: DismissDirection.,
      onDismissed: (direction) {
        print(direction);

        if (direction == DismissDirection.endToStart) {
          // item that will be removed
          _lastTaskUsed = _taskList[index];

          //remove item
          _taskList.removeAt(index);
          _saveFile();

          // Confirm with the user
          final snackBar = SnackBar(
            content: Text("Task removed!"),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: "Undo Tap Here",
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  _taskList.insert(index, _lastTaskUsed);
                });
                _saveFile();
              },
            ),
          );

          Scaffold.of(context).showSnackBar(snackBar);

        } else if (direction == DismissDirection.startToEnd) {
          
          AlertDialog updateAlert = AlertDialog(
            title: Text("Update the task"),
            content: TextField(
              controller: this._controllerTask,
              decoration: InputDecoration(
                labelText: _taskList[index].description,                
              ),
              onChanged: (text) {},
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: Text("Save"),
                onPressed: () {
                  _saveTask();
                  Navigator.pop(context);
                },
              )
            ],
          );

          showDialog(
            context: context,
            builder: (BuildContext context){
              return updateAlert;
            }
          );
          
          //Scaffold.of(context).

        }
      },
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete_forever,
              color: Colors.white,
            ),
          ],
        ),
      ),
      child: CheckboxListTile(
        title: Text(_taskList[index].description),
        value: _taskList[index].status,
        onChanged: (updateBox) {
          setState(() {
            _taskList[index].status = updateBox;
          });

          _saveFile();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
        backgroundColor: Colors.teal,
      ),

      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _taskList.length,
              itemBuilder: createListItems,
            ),
          ),
        ],
      ),

      //bottomNavigationBar: ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_to_photos),
        backgroundColor: Colors.teal,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Add a task"),
                  content: TextField(
                    controller: this._controllerTask,
                    decoration: InputDecoration(
                      labelText: "Type your task",
                      //fillColor : Colors.purple
                    ),
                    onChanged: (text) {},
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    FlatButton(
                      child: Text("Save"),
                      onPressed: () {
                        _saveTask();
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              });
        },
      ),
    );
  }
}
