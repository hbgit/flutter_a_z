import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_a_z/controll/RouteGenerator.dart';
import 'package:flutter_a_z/model/User.dart';

class AgendaTab extends StatefulWidget {
  AgendaTab({Key key}) : super(key: key);

  @override
  _AgendaTabState createState() => _AgendaTabState();
}

class _AgendaTabState extends State<AgendaTab> {
  //String _idUserLogIn;
  String _emailUserLogIn;

  @override
  void initState() {
    super.initState();
    _recoveryDataUser();
  }

  _recoveryDataUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser userLog = await auth.currentUser();
    //_idUserLogIn = userLog.uid;
    _emailUserLogIn = userLog.email;
  }

  Future<List<User>> _recoveryAgenda() async {
    Firestore db = Firestore.instance;

    QuerySnapshot querySnapshot = await db.collection("user").getDocuments();

    List<User> listUser = List();

    for (DocumentSnapshot item in querySnapshot.documents) {
      var data = item.data;
      if (data["email"] == _emailUserLogIn) continue;

      User user = User();
      user.idUser = item.documentID;
      user.email = data["email"];
      user.name = data["name"];
      user.urlImage = data["urlImage"];
      print(user.urlImage);

      listUser.add(user);
    }
    return listUser;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: _recoveryAgenda(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Container();
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
            return Container();
          case ConnectionState.done:
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                List<User> listItems = snapshot.data;
                User user = listItems[index];

                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, RouteGenerator.ROUTE_MSG,
                        arguments: user);
                  },
                  contentPadding: EdgeInsets.fromLTRB(15, 7, 15, 7),
                  leading: CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Colors.grey,
                      backgroundImage: user.urlImage != null
                          ? NetworkImage(user.urlImage)
                          : null),
                  title: Text(
                    user.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  subtitle: Text(
                    user.email,
                    style: TextStyle(fontSize: 12),
                  ),
                );
              },
            );
            break;
          default:
            return Container();
        }
      },
    );
  }
}
