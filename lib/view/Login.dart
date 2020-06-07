import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_a_z/controll/RouteGenerator.dart';
import 'package:flutter_a_z/model/User.dart';
import 'package:flutter_a_z/view/AddUser.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String _email, _password;
  String _msgError = "";

  String _validatePassWord(String value) {
    if (value.length == 0) {
      return "Password is Required";
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

  _showDialog(BuildContext context){
    AlertDialog showDia = AlertDialog(
      title: Text("Sign In Error"),
      content: Text(_msgError),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ],
    );

    showDialog(
      context: context,
      builder: (context){
        return showDia;
      }
    );
  }

  _signIn(User user){

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
      email: user.email, 
      password: user.password
    ).then((firebaseUser){
      Navigator.pushReplacementNamed(context, RouteGenerator.ROUTE_HOME);
    }).catchError((onError){
      setState(() {
        _msgError = "E-mail or Password is not correct, please try again.";
        _showDialog(context);
      });
    });

  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();
      
      print("Email $_email");
      print("Pass $_password");

      User user = User();
      user.email = _email;
      user.password = _password;

      _signIn(user);

    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
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
                Padding(
                  padding: EdgeInsets.only(bottom: 31),
                  child: Image.asset(
                    "assets/v11/logo.png",
                    width: 200,
                    height: 150,
                  ),
                ),
                Form(
                  key: _key,
                  autovalidate: _validate,
                  child: Column(
                    children: [
                      TextFormField(     
                        autofocus: true,                   
                        decoration: InputDecoration(
                            hintText: "E-mail",
                            counterText: "",
                            filled: true,
                            fillColor: Colors.white,
                            helperStyle:
                                TextStyle(color: Colors.white, fontSize: 15),
                            errorStyle:
                                TextStyle(color: Colors.white, fontSize: 21)),
                        keyboardType: TextInputType.emailAddress,
                        maxLength: 32,
                        validator: _validateEmail,
                        onSaved: (String v) {
                          _email = v;
                        },
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "Password",
                            counterText: "",
                            filled: true,
                            fillColor: Colors.white,
                            helperStyle:
                                TextStyle(color: Colors.white, fontSize: 15),
                            errorStyle:
                                TextStyle(color: Colors.white, fontSize: 21)),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        maxLength: 32,
                        validator: _validatePassWord,
                        onSaved: (String v) {
                          _password = v;
                        },
                      ),
                      SizedBox(height: 15.0),
                      RaisedButton(
                        onPressed: _sendToServer,
                        color: Colors.green,
                        textColor: Colors.white,
                        child: new Text("Let's go"),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: GestureDetector(
                    child: Text(
                      "Don't have an account? Sign up",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddUser()));
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
