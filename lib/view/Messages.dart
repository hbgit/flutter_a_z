import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_a_z/model/Chat.dart';
import 'package:flutter_a_z/model/Message.dart';
import 'package:flutter_a_z/model/User.dart';
import 'package:image_picker/image_picker.dart';

class Messages extends StatefulWidget {
  //Messages({Key key}) : super(key: key);

  final User user;

  Messages({this.user});

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  //File _img;
  bool _upImg = false;
  String _idUseLogIn;
  String _idUseTo;
  Firestore db = Firestore.instance;
  TextEditingController _controllerMsg = TextEditingController();
  List<String> listMsg = List();

  final _controller = StreamController<QuerySnapshot>.broadcast();
  ScrollController _scrollController = ScrollController(initialScrollOffset: 0);

  _saveChat(Message msg) {
    //Save chat to who sent
    Chat chatFrom = Chat();
    chatFrom.idFrom = _idUseLogIn;
    chatFrom.idTo = _idUseTo;
    chatFrom.msg = msg.msg;
    chatFrom.name = widget.user.name;
    chatFrom.pathPhoto = widget.user.urlImage;
    chatFrom.type = msg.type;
    chatFrom.save();

    //Save chat to who receiver
    Chat chatTo = Chat();
    chatTo.idFrom = _idUseTo;
    chatTo.idTo = _idUseLogIn;
    chatTo.msg = msg.msg;
    chatTo.name = widget.user.name;
    chatTo.pathPhoto = widget.user.urlImage;
    chatTo.type = msg.type;
    chatTo.save();
  }

  _sendMsg() {
    print("_sendMsg()");

    String txtMsg = _controllerMsg.text.toString();
    print("++++++" + txtMsg);

    if (txtMsg.isNotEmpty) {
      Message msg = Message();
      msg.idUser = _idUseLogIn;
      msg.msg = txtMsg;
      msg.urlImg = "";
      msg.type = "text";
      msg.date = Timestamp.now().toString();

      //Save msg to who sent
      _saveMsg(_idUseLogIn, _idUseTo, msg);

      //Save msg to receiver
      _saveMsg(_idUseTo, _idUseLogIn, msg);

      //Save chat
      _saveChat(msg);
    }
  }

  _saveMsg(String idUserFrom, String idUserDest, Message msg) async {
    Firestore db = Firestore.instance;

    await db
        .collection("messages")
        .document(idUserFrom)
        .collection(idUserDest)
        .add(msg.toMap());

    _controllerMsg.clear();
  }

  _sendPhoto() async {
    PickedFile imgSelected;
    final ImagePicker imgPicker = ImagePicker();

    imgSelected = await imgPicker.getImage(source: ImageSource.gallery);
        
    if (imgSelected != null) {      
      _upImg = true;
      String nameImg = DateTime.now().millisecondsSinceEpoch.toString();
      FirebaseStorage storage = FirebaseStorage.instance;
      StorageReference rootFolder = storage.ref();
      StorageReference file = rootFolder
          .child("messages")
          .child(_idUseLogIn)
          .child(nameImg + ".jpg");

      //Upload img
      StorageUploadTask task = file.putFile(File(imgSelected.path));

      task.events.listen((StorageTaskEvent event) {
        if (event.type == StorageTaskEventType.progress) {
          setState(() {
            _upImg = true;
          });
        } else if (event.type == StorageTaskEventType.success) {
          setState(() {
            _upImg = false;
          });
        }
      });

      //recovery img url
      task.onComplete.then((StorageTaskSnapshot snapshot) {
        _recoveryImgUrl(snapshot);
      });
    }

  }

  Future _recoveryImgUrl(StorageTaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();

    Message msg = Message();
    msg.idUser = _idUseLogIn;
    msg.msg = "";
    msg.urlImg = url;
    msg.type = "image";
    msg.date = Timestamp.now().toString();

    // save msg to who sent
    _saveMsg(_idUseLogIn, _idUseTo, msg);

    // save msg to who receiver
    _saveMsg(_idUseTo, _idUseLogIn, msg);
  }

  _recoveryDataUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser userLogIn = await auth.currentUser();
    _idUseLogIn = userLogIn.uid;
    _idUseTo = widget.user.idUser;

    _addListenerMsg();
  }

  Stream<QuerySnapshot> _addListenerMsg() {
    final stream = db
        .collection("messages")
        .document(_idUseLogIn)
        .collection(_idUseTo)
        .orderBy("date", descending: false)
        .snapshots();

    stream.listen((data) {
      //print(data.toString());
      _controller.add(data);
      Timer(Duration(seconds: 1), () {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
    });

    return stream;
  }

  @override
  void initState() {
    super.initState();
    _recoveryDataUser();
  }

  @override
  Widget build(BuildContext context) {
    print("***********" + _upImg.toString());

    var msgBox = Container(
      padding: EdgeInsets.all(7),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 7),
              child: TextField(
                controller: _controllerMsg,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(31, 7, 31, 7),
                  hintText: "Type a message...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(31)),
                  prefixIcon: _upImg
                      ? CircularProgressIndicator()
                      : IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: () {
                            //print("_sendPhoto()");
                            _sendPhoto();
                          },
                          //onPressed: _sendPhoto(),
                        ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Color(0xff075E54),
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
            mini: true,
            onPressed: () {
              print("HERE");
              print(_controllerMsg.text.toString());
              _sendMsg();
            },
          ),
        ],
      ),
    );

    var stream = StreamBuilder(
      stream: _controller.stream,
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          //return Container();
          //break;
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: [Text("Loading ..."), CircularProgressIndicator()],
              ),
            );
            break;
          case ConnectionState.active:
          //return Container();
          //break;
          case ConnectionState.done:
            print(">> ConnectionState.done");
            QuerySnapshot querySnapshot = snapshot.data;
            if (snapshot.hasError) {
              return Text("Error, sorry about it :)");
            } else {
              print("Listing msg");
              return Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: querySnapshot.documents.length,
                  itemBuilder: (context, index) {
                    List<DocumentSnapshot> msg =
                        querySnapshot.documents.toList();
                    DocumentSnapshot item = msg[index];

                    double sizeContainer =
                        MediaQuery.of(context).size.width * 0.8;

                    Alignment ali = Alignment.centerRight;
                    Color cor = Color(0xffd2ffa5);
                    if (_idUseLogIn != item["idUser"]) {
                      ali = Alignment.centerLeft;
                      cor = Colors.white;
                    }

                    return Align(
                      alignment: ali,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Container(
                          width: sizeContainer,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: cor,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: item["type"] == "text"
                              ? Text(item["msg"],
                                  style: TextStyle(fontSize: 17))
                              : Image.network(item["urlImg"]),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            break;
          default:
            return Container();
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              maxRadius: 20,
              backgroundColor: Colors.grey,
              backgroundImage: widget.user.urlImage != null
                  ? NetworkImage(widget.user.urlImage)
                  : null,
            ),
            Padding(
              padding: EdgeInsets.only(left: 7),
              child: Text(widget.user.name),
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/v11/background.jpg"),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(7),
            child: Column(
              children: [
                stream,
                msgBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
