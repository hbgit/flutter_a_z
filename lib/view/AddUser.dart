import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_a_z/controll/RouteGenerator.dart';
import 'package:flutter_a_z/model/User.dart';

class AddUser extends StatefulWidget {
  AddUser({Key key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String _name, _email, _password;

  String _validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String _validatePassword(String value) {    
    if (value.length < 5) {
      return "The Password length > 5";
    } 
    return null;
  }

  String _validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  _addNewUser(User user){
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.createUserWithEmailAndPassword(
      email: user.email, 
      password: user.password
    ).then((firebaseUser){
      
      Firestore db = Firestore.instance;
      
      db.collection("user")
      .document(firebaseUser.user.uid)
      .setData(user.toMap());

      Navigator.pushNamedAndRemoveUntil(
        context, 
        RouteGenerator.ROUTE_HOME,
        (_) => false
      );

    }).catchError((onError){
      print("ERROR ADD USER" + onError.toString());
    });
  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      // No any error in validation
      
      _key.currentState.save();
      print("Name $_name");
      print("Email $_email");
      print("Pass $_password");

      User user = User();
      user.name = _name;
      user.email = _email;
      user.password = _password;

      _addNewUser(user);


    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }

  Widget _formAddUser() {
    return Column(
      children: [
        TextFormField(
          autofocus: true,
          decoration: InputDecoration(
              hintText: "Name",
              filled: true,
              fillColor: Colors.white,
              helperStyle: TextStyle(color: Colors.white, fontSize: 15),
              errorStyle: TextStyle(color: Colors.white, fontSize: 21)),
          keyboardType: TextInputType.text,
          maxLength: 32,
          validator: _validateName,
          onSaved: (String v) {
            _name = v;
          },
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: "E-mail",
              filled: true,
              fillColor: Colors.white,
              helperStyle: TextStyle(color: Colors.white, fontSize: 15),
              errorStyle: TextStyle(color: Colors.white, fontSize: 21)),
          keyboardType: TextInputType.emailAddress,
          maxLength: 32,
          validator: _validateEmail,
          onSaved: (String v) {
            _email = v;
          },
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: "Password",
              filled: true,
              fillColor: Colors.white,
              helperStyle: TextStyle(color: Colors.white, fontSize: 15),
              errorStyle: TextStyle(color: Colors.white, fontSize: 21)),
          keyboardType: TextInputType.text,
          obscureText: true,
          maxLength: 32,
          validator: _validatePassword,
          onSaved: (String v) {
            _password = v;
          },
        ),
        SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              color: Colors.red,
              textColor: Colors.white,
              child: new Text('Cancel'),
            ),
            RaisedButton(
              onPressed: _sendToServer,
              color: Colors.green,
              textColor: Colors.white,
              child: new Text('Send'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xff075E54)),
        padding: EdgeInsets.all(15),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 31),
                      child: Image.asset(
                        "assets/v11/usuario.png",
                        width: 100,
                        height: 50,
                      ),
                    ),
                    Text(
                      "New User :)",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Form(
                  key: _key,
                  autovalidate: _validate,
                  child: _formAddUser(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
