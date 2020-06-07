import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_a_z/controll/RouteGenerator.dart';
import 'package:flutter_a_z/view/AgendaTab.dart';
import 'package:flutter_a_z/view/ChatTab.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  
  TabController _tabController;
  List<String> itemsMenu = [
    "Settings",
    "Sign Out"
  ];

  String _emailUser = "";

  Future _recoveryDataUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser userLogIn = await auth.currentUser();

    setState(() {
      _emailUser = userLogIn.email;
    });

  }
  
  
  @override
  void initState() {    
    super.initState();

    _recoveryDataUser();

    _tabController = TabController(
      length: 2,
      vsync: this
    );
  }

  _optionMenuItem(String option){
    switch (option) {
      case "Settings":
        print("Going to Settings");
        Navigator.pushReplacementNamed(context, RouteGenerator.ROUTE_SETTINGS);
        break;
      case "Sign Out":
        print("Sign Out");
        _signOut();
        break;
    }
  }

  _signOut() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    Navigator.pushReplacementNamed(context, RouteGenerator.ROUTE_LOGIN);
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(        
        title: Text("ChatApp - " + _emailUser),
        bottom: TabBar(
          indicatorWeight: 4,
          labelStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold
          ),
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: "Chat",),
            Tab(text: "Agenda",)
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: _optionMenuItem,
            itemBuilder: (context){
              return itemsMenu.map((String item){
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ChatTab(),
          AgendaTab()
        ],
      ),
    );
  }
}