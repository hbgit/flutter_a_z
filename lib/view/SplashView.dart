import 'package:flutter/material.dart';
import 'package:flutter_a_z/controll/Auth.dart';
import 'package:flutter_a_z/view/HomeScreen.dart';
import 'package:flutter_a_z/view/Login.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final Auth _auth = Auth();
  String _route;

  Future<bool> _initialCheck() async {
    bool isLogged = await _auth.isLogged();
    return Future.delayed(const Duration(seconds: 5)).then((value) {
      _route = isLogged ? "/home" : "/";
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff075E54),
      child: FutureBuilder(
        future: _initialCheck(),
        builder: (context, snapshot) {
          print(">>" + snapshot.data.toString());
          if (snapshot.hasData && snapshot.data == true) {
            print("I am here");
            print(_route);
            return _route == "/home"
                  ? HomeScreen()
                  : Login();
          } else {
            return Center(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Image.asset("assets/v11/logo.png").image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(padding: EdgeInsets.only(bottom: 80),
                    child: CircularProgressIndicator(),)
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
