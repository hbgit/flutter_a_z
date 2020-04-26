import 'package:flutter/material.dart';
import 'package:flutter_a_z/model/Task.dart';
import 'package:flutter_a_z/view/GetPriorityPickerDialog.dart';
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
  //TextEditingController _controllerTaskUpdate = TextEditingController();

  // attr
  List _taskList = [];
  Task _lastTaskUsed = Task();
  double _priorityTask = 0.0;
  Color _priorityColor = Colors.green;
  // EdgeInsets _sliderEdge = EdgeInsets.all(15);

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
    task.priority = _priorityTask;
    task.status = false;
    task.id = DateTime.now().millisecondsSinceEpoch.toString();

    setState(() {
      _taskList.add(task);
    });

    _saveFile();
    _controllerTask.text = "";
    _priorityTask = 0.0;
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

  Future<bool> _showPriorityPickerDialog() async {
    final resultDialog = await showDialog<List>(
      context: context,
      builder: (context) => GetPriorityPickerDialog(
          initialPriority: _priorityTask,
          initCtrlTask: _controllerTask,
        ),
    );

    if(resultDialog.length > 0){
      //setState(() {
        // print(resultDialog);
        _priorityTask = resultDialog[0];
        _controllerTask = resultDialog[1];
      //});
      return true;
    }else{
      return false;
    }
  }

  Widget slideRightContainer() {
    return Container(
      color: Colors.red,
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.delete_forever,
            color: Colors.white,
          ),
          Text(
            " Delete",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          /*SizedBox(
            width: 20,
          ),*/
        ],
      ),
    );
  }

  Widget slideLeftContainer() {
    return Container(
      color: Colors.green,
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          Text(
            " Edit",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          /*SizedBox(
            width: 20,
          ),*/
        ],
      ),
    );
  }
  

  // ListView using Dismissible of this Screen
  Widget createListItems(context, index) {

    if (_taskList[index].priority >= 5.0){
      _priorityColor = Colors.red;
    }else{
      _priorityColor = Colors.green;
    }

    return Dismissible(
      key: Key(UniqueKey().toString()),
      //key: Key(_taskList[index].id),
      //direction: DismissDirection.,
      onDismissed: (direction) {
        // print(direction);

        if (direction == DismissDirection.endToStart) {
          // _sliderEdge = EdgeInsets.all(0);
          // item that will be removed
          _lastTaskUsed = _taskList[index];

          //remove item
          setState(() {
            _taskList.removeAt(index);  
          });
          
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

          this._controllerTask.text = _taskList[index].description;
          this._priorityTask = _taskList[index].priority;
          
          _showPriorityPickerDialog().then((value) {
            if(value){
              setState(() {                
                _taskList[index].description = this._controllerTask.text;
                _taskList[index].priority = this._priorityTask;
              }); 
              //print(_taskList[index].description);             
              _saveFile();
              this._controllerTask.text = "";
              this._priorityTask = 0.0;
            }
          });          
        }
      },
      background: slideLeftContainer(),
      secondaryBackground: slideRightContainer(),
      child: CheckboxListTile(
        title: Text(_taskList[index].description),
        subtitle: Text(          
          "Priority: ${_taskList[index].priority.round().toString()}", 
          style: TextStyle(
            backgroundColor: _priorityColor,
            color: Colors.white,
            fontWeight: FontWeight.bold 
          ),         
        ),
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
          _showPriorityPickerDialog().then((value) {
            if(value){
              _saveTask();
              this._controllerTask.text = "";
              this._priorityTask = 0.0;
            }
          });
        },
      ),
    );
  }
}
