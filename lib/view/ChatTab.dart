import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_a_z/controll/RouteGenerator.dart';
import 'package:flutter_a_z/model/Chat.dart';
import 'package:flutter_a_z/model/User.dart';

class ChatTab extends StatefulWidget {
  ChatTab({Key key}) : super(key: key);

  @override
  _ChatTabState createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  List<Chat> _listChat = List();
  final _controller = StreamController<QuerySnapshot>.broadcast();
  Firestore db = Firestore.instance;
  String _idUserLogIn;

  Stream<QuerySnapshot> _addListenerChat() {
    print(_idUserLogIn);

    final stream = db
        .collection("chat")
        .document(_idUserLogIn)
        .collection("lastchat")
        .snapshots();

    stream.listen((data) {
      print(data);
      _controller.add(data);
    });

    return stream;
  }

  _recoveryDataUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser userLog = await auth.currentUser();
    _idUserLogIn = userLog.uid;

    _addListenerChat();
  }

  @override
  void initState() {
    super.initState();

    _recoveryDataUser();

    Chat chat = Chat();
    chat.name = "";
    chat.msg = "";
    chat.pathPhoto = "";
    _listChat.add(chat);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            print(">>>> ConnectionState.waiting");
            return Center(
              child: CircularProgressIndicator(),
            );
          //break;
          case ConnectionState.active:
          case ConnectionState.done:
            print(">>>> ConnectionState.done");
            if (snapshot.hasError) {
              return Text("ERROR to load data :(");
            } else {
              print(">>>> Has data");
              QuerySnapshot querySnap = snapshot.data;
              if (querySnap.documents.length == 0) {
                return Center(
                  child: Text(
                    "You do not have msg, so let's start :)",
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                );
              }

              return ListView.builder(
                itemCount: _listChat.length,
                itemBuilder: (context, index) {
                  print(">>>> Generating ListView");

                  List<DocumentSnapshot> chats = querySnap.documents.toList();
                  DocumentSnapshot item = chats[index];
                  print(item);

                  String urlImg = item["pathPhoto"];
                  String type = item["type"];
                  String msg = item["msg"];
                  String name = item["name"];
                  String idTo = item["idTo"];

                  User user = User();
                  user.name = name;
                  print(">>>> " + user.name);
                  user.urlImage = urlImg;
                  print(user.urlImage);
                  user.idUser = idTo;

                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, RouteGenerator.ROUTE_MSG,
                          arguments: user);
                    },
                    contentPadding: EdgeInsets.fromLTRB(15, 7, 15, 7),
                    leading: CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          urlImg != null ? NetworkImage(urlImg) : null,
                    ),
                    title: Text(
                      name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    subtitle: Text(type == "text" ? msg : "Image",
                        style: TextStyle(color: Colors.grey, fontSize: 15)),
                  );
                },
              );
            }
            break;
          default:
            print(">>>> Default");
            return Container();
        }
      },
    );
  }
}
