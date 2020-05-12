import 'package:flutter/material.dart';
import 'package:flutter_a_z/controll/NoteControll.dart';
import 'package:flutter_a_z/model/Note.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //attr
  var _db = NoteControll();
  List<Note> _listNotes = List<Note>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();


  //Screen Actions
  _recoveryNotes() async {

    print(">> _recoveryNotes");

    List noteRec = await _db.recoveryNotes();
    print(" Notes: ${noteRec.length}");

    List<Note> listTmp = List<Note>();

    noteRec.forEach((element) { 
      //print(element);
      Note note = Note.fromMap(element);
      listTmp.add(note);
    });

    setState(() {
      _listNotes = listTmp;
    });

    listTmp = null;
  }

  @override
  void initState() { 
    super.initState();
    print(">> initState");
    
    _recoveryNotes();
  }

  _saveUpdateNote( {Note noteSected} ) async {
    String title = _titleController.text;
    String desc  = _descController.text;

    if(noteSected == null){
      print("Save NOTE");
      Note note = Note(title, desc, DateTime.now().toString());
      int result = await _db.saveNote(note);
      print(result);
    }else{
      print("Save UPDATE");
      noteSected.title = title;
      noteSected.desc = desc;
      noteSected.date = DateTime.now().toString();
      int result = await _db.updateNote(noteSected);
      print(result);
    }

    _titleController.clear();
    _descController.clear();

    _recoveryNotes();


  }

  _showDialogToAdd( {Note note} ){
    String flagSaveUpdate = "";
    if(note == null){
      _titleController.text = "";
      _descController.text = "";
      flagSaveUpdate = "Save";
    }else{
      _titleController.text = note.title;
      _descController.text = note.desc;
      flagSaveUpdate = "Update";
    }    

    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("$flagSaveUpdate Note"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Title",
                  hintText: "Type a note title ..."
                ),
              ),
              TextField(
                controller: _descController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Description",
                  hintText: "Type a note description ..."
                ),
              ),
            ],
          ),
          actions: [
            FlatButton(
              onPressed: () => Navigator.pop(context),
              color: Colors.red,
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            FlatButton(
              onPressed: (){                
                _saveUpdateNote(noteSected: note);
                Navigator.pop(context);
              },
              color: Colors.green,
              child: Text(
                "Save",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          ],
        );
      }
    );

  }

  _formatDate(String date){

    initializeDateFormatting("pt_BR");

    var pattern = DateFormat.yMd("pt_BR");

    DateTime dateConvert = DateTime.parse(date);
    String newDatePattern = pattern.format(dateConvert);

    return newDatePattern;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      appBar: AppBar(
        title: Text("Keep Notes"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _listNotes.length, 
              itemBuilder: (context, index){
                
                final note = _listNotes[index];

                return Card(
                  color: Colors.green[200],
                  elevation: 5,
                  child: ListTile(
                    title: Text(
                      note.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${_formatDate(note.date)} - ${note.desc}"
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: (){},
                          child: Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: Padding(
                            padding: EdgeInsets.only(right: 0),
                            child: Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: Icon(Icons.note_add),
        onPressed: (){
          _showDialogToAdd();
        },
      ),
    );
  }
}