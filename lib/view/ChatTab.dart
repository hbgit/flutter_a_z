import 'package:flutter/material.dart';
import 'package:flutter_a_z/model/Chat.dart';

class ChatTab extends StatefulWidget {
  ChatTab({Key key}) : super(key: key);

  @override
  _ChatTabState createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  List<Chat> listChat = [
    Chat("Ana Clara", "Olá tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-36cd8.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=97a6dbed-2ede-4d14-909f-9fe95df60e30"),
    Chat("Pedro Silva", "Me manda o nome daquela série que falamos!",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-36cd8.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=659622c6-4a5d-451a-89b9-05712c64b526"),
    Chat("Marcela Almeida", "Vamos sair hoje?",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-36cd8.appspot.com/o/perfil%2Fperfil3.jpg?alt=media&token=99ad2441-7b1a-4940-879c-c62ae4535a01"),
    Chat("José Renato", "Não vai acreditar no que tenho para te contar...",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-36cd8.appspot.com/o/perfil%2Fperfil4.jpg?alt=media&token=ff26db77-6554-4072-a238-f06ba1af4e3d"),
    Chat("Jamilton Damasceno", "Curso novo!! depois dá uma olhada!!",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-36cd8.appspot.com/o/perfil%2Fperfil5.jpg?alt=media&token=f6fd2892-f8bd-47bc-b3fc-f0ba0a48fac5"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listChat.length,
      itemBuilder: (context, index) {
        Chat chat = listChat[index];

        return ListTile(
          contentPadding: EdgeInsets.fromLTRB(15, 7, 15, 7),
          leading: CircleAvatar(
            maxRadius: 30,
            backgroundColor: Colors.lightGreen,
            backgroundImage: NetworkImage(chat.pathPhoto),
          ),
          title: Text(
            chat.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          subtitle: Text(
            chat.msg,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        );
      },
    );
  }
}
