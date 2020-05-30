import 'package:flutter/material.dart';

class AgendaTab extends StatefulWidget {
  AgendaTab({Key key}) : super(key: key);

  @override
  _AgendaTabState createState() => _AgendaTabState();
}

class _AgendaTabState extends State<AgendaTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text("Agenda"),
    );
  }
}