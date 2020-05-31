import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_a_z/controll/RouteGenerator.dart';
import 'package:image_picker/image_picker.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController _ctrName = TextEditingController();
  PickedFile _image;
  String _idUserLogIn;
  bool _upImage = false;
  String _urlRecoveryImage;

  _recoveryDataUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser userNow = await auth.currentUser();
    _idUserLogIn = userNow.uid;

    Firestore db = Firestore.instance;
    DocumentSnapshot snapshot =
        await db.collection("user").document(_idUserLogIn).get();

    Map<String, dynamic> data = snapshot.data;
    _ctrName.text = data["name"];

    if (data["urlImage"] != null) {
      _urlRecoveryImage = data["urlImage"];
    }
  }

  _updateUrlImageFireStore(String url) {
    Firestore db = Firestore.instance;
    Map<String, dynamic> dataUpdate = {"urlImage": url};

    db.collection("user").document(_idUserLogIn).updateData(dataUpdate);
  }

  Future _recoveryUrlImage(StorageTaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();
    _updateUrlImageFireStore(url);

    setState(() {
      _urlRecoveryImage = url;
    });
  }

  Future _uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference root = storage.ref();
    StorageReference fileFrom =
        root.child("profile").child(_idUserLogIn + ".jpg");

    //Upload image
    StorageUploadTask task = fileFrom.putFile(File(_image.path));

    //Check progress
    task.events.listen((StorageTaskEvent storageEvent) {
      if (storageEvent.type == StorageTaskEventType.progress) {
        setState(() {
          _upImage = true;
        });
      } else if (storageEvent.type == StorageTaskEventType.success) {
        setState(() {
          _upImage = false;
        });
      }
    });

    //Recovery url from Image
    task.onComplete.then((StorageTaskSnapshot snapshot) {
      _recoveryUrlImage(snapshot);
    });
  }

  Future _recoveryImage(String fromImage) async {
    PickedFile imageOp;
    final ImagePicker _imgPicker = ImagePicker();

    switch (fromImage) {
      case "camera":
        imageOp = await _imgPicker.getImage(source: ImageSource.camera);
        break;
      case "galeria":
        imageOp = await _imgPicker.getImage(source: ImageSource.gallery);
        break;
    }

    _image = imageOp;
    setState(() {
      if (_image != null) {
        _upImage = true;
        _uploadImage();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _recoveryDataUser();
  }

  _updateNameFirestore() {
    String name = _ctrName.text;
    Firestore db = Firestore.instance;

    Map<String, dynamic> dataUpdate = {"name": name};

    db.collection("user").document(_idUserLogIn).updateData(dataUpdate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacementNamed(context, RouteGenerator.ROUTE_HOME),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    child: _upImage
                        ? CircularProgressIndicator()
                        : CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.grey,
                            backgroundImage: _urlRecoveryImage != null
                                ? NetworkImage(_urlRecoveryImage)
                                : null)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      child: Text("Câmera"),
                      onPressed: () {
                        _recoveryImage("camera");
                      },
                    ),
                    FlatButton(
                      child: Text("Galeria"),
                      onPressed: () {
                        _recoveryImage("galeria");
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(7),
                  child: TextField(
                    controller: _ctrName,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 21),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(31, 15, 31, 15),
                        hintText: "Name",
                        filled: true,
                        fillColor: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 9),
                  child: RaisedButton(
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white, fontSize: 21),
                    ),
                    color: Colors.green,
                    padding: EdgeInsets.fromLTRB(31, 15, 31, 15),
                    onPressed: () {
                      _updateNameFirestore();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
