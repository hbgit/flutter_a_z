import 'package:flutter/material.dart';

// move the dialog into it's own stateful widget.
// It's completely independent from your page
// this is good practice
class GetPriorityPickerDialog extends StatefulWidget {
  final double initialPriority;
  final TextEditingController initCtrlTask;

  GetPriorityPickerDialog({Key key, this.initialPriority, this.initCtrlTask}) : super(key: key);

  @override
  _GetPriorityPickerDialogState createState() =>
      _GetPriorityPickerDialogState();
}

class _GetPriorityPickerDialogState extends State<GetPriorityPickerDialog> {
  //attr to return
  double _priorityValue;  
  TextEditingController _controllerTask = TextEditingController();
  List _listResult = [];

  //widget
  Color _divCor = Colors.green;
  Text _titleDialog = Text("Add your task");

  @override
  void initState() {
    super.initState();    
    _priorityValue = widget.initialPriority;    
    if(widget.initCtrlTask.text.isNotEmpty){
      _controllerTask.text = widget.initCtrlTask.text;
      if(widget.initialPriority >= 5.0){
        _divCor = Colors.red;
      }      
      _titleDialog = Text("Update your task");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: _titleDialog,
      content: Container(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    controller: this._controllerTask,
                    decoration: InputDecoration(
                      labelText: "Type your task",
                      //fillColor : Colors.purple
                    ),
                    onChanged: (text) {},
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("Add the priority low (0) to high (10):"),
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Slider(
                    value: _priorityValue,
                    min: 0,
                    max: 10,
                    divisions: 3,
                    activeColor: _divCor,
                    inactiveColor: Colors.teal,
                    label: _priorityValue.round().toString(),
                    onChanged: (value) {
                      if (value >= 5.0) {
                        //print(value);
                        setState(() {
                          _divCor = Colors.red;
                          _priorityValue = value;
                        });
                      } else {
                        setState(() {
                          _divCor = Colors.green;
                          _priorityValue = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          autofocus: false,
          color: Colors.red,
          child: Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          autofocus: false,
          color: Colors.green,
          child: Text("Save"),
          onPressed: () {
            // Use the second argument of Navigator.pop(...) to pass
            // back a result to the page that opened the dialog
            _listResult.add(_priorityValue);
            _listResult.add(_controllerTask);
            Navigator.pop(context, _listResult);
          },          
        )
      ],
    );
  }
}
