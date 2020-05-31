import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_a_z/model/Message.dart';
import 'package:flutter_a_z/model/User.dart';

class Messages extends StatefulWidget {
  //Messages({Key key}) : super(key: key);

  final User user;

  Messages({this.user});

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  String _idUseLogIn;
  String _idUseDest;

  List<String> listMsg =[
    "Olá meu amigo, tudo bem?",
    "Tudo ótimo!!! e contigo?",
    "Estou muito bem!! queria ver uma coisa contigo, você vai na corrida de sábado?",
    "Não sei ainda :(",
    "Pq se você fosse, queria ver se posso ir com você...",
    "Posso te confirma no sábado? vou ver isso",
    "Opa! tranquilo",
    "Excelente!!",
    "Estou animado para essa corrida, não vejo a hora de chegar! ;) ",
    "Vai estar bem legal!! muita gente",
    "vai sim!",
    "Lembra do carro que tinha te falado",
    "Que legal!!"
  ];

  TextEditingController _controllerMsg = TextEditingController();

  _saveMsg(String idUserFrom, String idUserDest, Message msg) async {
    Firestore db = Firestore.instance;

    await db.collection("messages")
      .document(idUserFrom)
      .collection(idUserDest)
      .add(msg.toMap());

    _controllerMsg.clear();
  }

  _sendPhoto(){

  }
  
  
  _sendMsg(){
    
    String txtMsg = _controllerMsg.text;
    if(txtMsg.isNotEmpty){
      Message msg = Message();
      msg.idUser = _idUseLogIn;
      msg.msg = txtMsg;
      msg.urlImg = "";
      msg.type = "texto";

      _saveMsg(_idUseLogIn, _idUseDest, msg);
    }

  }


  @override
  Widget build(BuildContext context) {

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
                  prefixIcon: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: _sendPhoto(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    var listView = Expanded(
      child: ListView.builder(
        itemCount: listMsg.length,
        itemBuilder: (context, index){
          double sizeContainer = MediaQuery.of(context).size.width * 0.8;
          Alignment ali = Alignment.centerRight;
          Color cor = Color(0xffd2ffa5);
          if( index % 2 == 0){
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
                  borderRadius: BorderRadius.all(Radius.circular(7))
                ),
                child: Text(
                  listMsg[index],
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          );
        },
      ),
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
            fit: BoxFit.cover
          ),
        ),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(7),
            child: Column(
              children: [
                listView,
                msgBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}